class ReviewsController < ApplicationController
  before_action :authenticate_user?
  before_action :regulate_user!
  before_action :set_listing, :set_reservation, :set_review

  def new
    @review = @reservation.build_review
    @reservation.save_review_landed_at_now if @reservation.review_landed_at.blank?
  end

  def create
    @review = @reservation.build_review(review_params)
    respond_to do |format|
      if @review.save
        @reservation.save_reviewed_at_now
        # if ReviewMailer.send_review_reply_notification(@reservation, @review).deliver_later!(wait: 1.minute) # if you want to use active job, use this line.
        if ReviewMailer.send_review_reply_notification(@reservation, @review).deliver_now! # if you don't want to use active job, use this line.
          @reservation.save_reply_mail_sent_at_now
          format.html { redirect_to root_path, notice: I18n.t('alerts.review.save.success', model: Review.model_name.human, host: t('name.host')) }
          format.json { render :show, status: :created, location: @review }
        end
      else
        format.html { redirect_to root_path, alert: I18n.t('alerts.review.save.failure', model: Review.model_name.human) }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

private
  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  def set_reservation
    @reservation = @listing.reservations.find(params[:reservation_id])
  end

  def set_review
    @review = @reservation.review
  end

  def regulate_user!
    reservation = Reservation.where(id: params[:reservation_id].to_i).first
    if reservation.present?
      if current_user.id == reservation.guest_id
        if Review.exists?(reservation_id: reservation.id, guest_id: current_user.id)
          redirect_to root_path, alert: I18n.t('alerts.regulate_user.entry.duplicated')
        elsif Time.zone.now > reservation.review_expiration_date
          redirect_to root_path, alert: I18n.t('alerts.regulate_term.expired', review: Review.model_name.human)
        end
      else
        redirect_to root_path, alert: I18n.t('alerts.regulate_user.user_id.failure')
      end
    else
      redirect_to root_path, alert: I18n.t('alerts.regulate_user.reservation_id.failure', rsrv: Reservation.model_name.human)
    end
  end

  def review_params
    params \
      .require(:review) \
      .permit(:listing_id, :host_id, :guest_id, :accuracy, :communication, :cleanliness, :location, :check_in, :cost_performance, :total, :msg) \
      .merge(listing_id: @listing.id, host_id: @listing.user.id, guest_id: current_user.id)
  end
end
