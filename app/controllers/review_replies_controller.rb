class ReviewRepliesController < ApplicationController
  before_action :authenticate_user!
  before_action :regulate_user!
  before_action :set_listing, :set_reservation, :set_review, :set_review_reply

  def new
    @review_reply = @review.build_review_reply
    @reservation.save_reply_landed_at_now if @reservation.reply_landed_at.blank?
  end

  def create
    @review_reply = @review.build_review_reply(review_reply_params)
    respond_to do |format|
      if @review_reply.save
        @reservation.save_replied_at_now
        @reservation.save_review_opened_at_now
        @review.calc_average
        format.html { redirect_to root_path, notice: I18n.t('alerts.review_reply.save.success', model: Review.model_name.human, review: ReviewReply.model_name.human) }
        format.json { render :show, status: :created, location: @review_reply }
      else
        format.html { redirect_to root_path, notice: I18n.t('alerts.review_reply.save.failure', model: ReviewReply.model_name.human) }
        format.json { render json: @review_reply.errors, status: :unprocessable_entity }
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

  # Use callbacks to share common setup or constraints between actions.
  def set_review_reply
    @review_reply = @review&.review_reply
  end

  def regulate_user!
    reservation = Reservation.where(id: params[:reservation_id].to_i).first
    review = Review.where(reservation_id: params[:reservation_id].to_i).first
    if reservation.present?
      if current_user.id == reservation.host_id
        if review.present?
          # rubocop:disable Metrics/BlockNesting
          redirect_to root_path, alert: I18n.t('alerts.regulate_user.entry.duplicated') if ReviewReply.exists?(review_id: review.id)
          # rubocop:enable Metrics/BlockNesting
        else
          redirect_to root_path, alert: I18n.t('alerts.regulate_user.review_not_found', review: Review.model_name.human)
        end
      else
        redirect_to root_path, alert: I18n.t('alerts.regulate_user.user_id.failure')
      end
    else
      direct_to root_path, alert: I18n.t('alerts.regulate_user.reservation_id.failure', rsrv: Reservation.model_name.human)
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def review_reply_params
    params.require(:review_reply).permit(:msg)
  end
end
