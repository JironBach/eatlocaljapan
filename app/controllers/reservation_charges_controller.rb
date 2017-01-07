class ReservationChargesController < ApplicationController
  before_action :authenticate_user?
  before_action :load_listing
  before_action :load_charges, only: [:index]
  before_action :create_charge, only: [:new, :create]
  before_action :load_charge, only: [:edit, :update, :destroy]

  authorize_resource :listing, parent_action: :update

  def index
  end

  def new
  end

  def create
    respond_to do |format|
      if @listing.with_lock { @charge.save }
        format.html { redirect_to listing_reservation_charges_path(@listing), notice: I18n.t(:success, model: Charge.model_name.human, scope: [:alerts, :charges, :create]) }
      else
        format.html { render 'new' }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @listing.with_lock { @charge.save }
        format.html { redirect_to listing_reservation_charges_path(@listing), notice: I18n.t(:success, model: Charge.model_name.human, scope: [:alerts, :charges, :update]) }
      else
        format.html { render 'edit' }
      end
    end
  end

  def destroy
    respond_to do |format|
      if current_user.with_lock { @charge.destroy }
        format.html { redirect_to listing_reservation_charges_path(@listing), notice: I18n.t(:success, model: Charge.model_name.human, scope: [:alerts, :charges, :destroy]) }
      else
        format.html { redirect_to listing_reservation_charges_path(@listing), alert: I18n.t(:failure, model: Charge.model_name.human, scope: [:alerts, :charges, :destroy]) }
      end
    end
  end

private
  def load_listing
    @listing = Listing.find(params[:listing_id])
  end

  def load_charges
    @charges = @instances = @listing.charges.reservation
  end

  def create_charge
    @charge = @instance = @listing.charges.build(reservation_charge_params.merge(status: Charge.statuses[:ordered], ordered_at: Time.zone.now))
  end

  def load_charge
    @charge = @instance = @listing.charges.reservation.find(params[:id]).tap { |instance| instance.assign_attributes(reservation_charge_params) }
  end

  # TODO: need to reconsider of behavior around cancelation
  def reservation_charge_params
    params.fetch(:charge, {}).permit(:type, :payment_method_id).merge(service: Service.reservation)
  end
end