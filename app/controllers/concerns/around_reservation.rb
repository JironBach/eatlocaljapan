module AroundReservation
  extend ActiveSupport::Concern

  included do |klass|
  end

  class_methods do
  end

  def reservation_available?(listing=nil)
    unless (listing || @listing).reservation_available?
      redirect_to \
        listing_reservation_charges_path(listing || @listing),
        notice: I18n.t(:not_yat, model: Charge.model_name.human, scope: [:alerts, :reservation, :requirement, :charge])
    end
  end

  def reservation_configured?(listing=nil)
    unless (listing || @listing).reservation_configured?
      redirect_to \
        listing_reservation_setting_path(listing || @listing),
        notice: I18n.t(:not_yat, model: Setting.model_name.human, scope: [:alerts, :reservation, :requirement, :setting])
    end
  end

  def reservation_enabled?(listing=nil)
    unless (listing || @listing).reservation_enabled?
      redirect_to \
        listing_path(listing || @listing),
        notice: I18n.t(:not_yat, model: Reservation.model_name.human, scope: [:alerts, :reservation, :requirement, :configure])
    end
  end
end
