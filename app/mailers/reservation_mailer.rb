class ReservationMailer < ApplicationMailer
  def send_new_reservation_notification_to_guest(reservation)
    @to_user, @from_user = [:guest, :host].map { |user_type| reservation.send(user_type) }
    @listing = reservation.listing

    # rubocop:disable Style/SymbolProc
    mail(
      to: @to_user.email,
      subject: I18n.t('reservation_mailer.send_new_reservation_notification_to_guest.subject')
    ) do |format|
      format.text
    end
    # rubocop:enable Style/SymbolProc
  end

  def send_new_reservation_notification_to_host(reservation)
    @to_user, @from_user = [:host, :guest].map { |user_type| reservation.send(user_type) }
    @listing = reservation.listing

    # rubocop:disable Style/SymbolProc
    mail(
      to: @to_user.email,
      subject: '新しい予約/New Reservation'
    ) do |format|
      format.text
    end
    # rubocop:enable Style/SymbolProc
  end

  def send_update_reservation_notification(reservation, from)
    @from_user, @to_user = [from, from == :guest ? :host : :guest].map { |user_type| reservation.send(user_type) }
    @message_thread = MessageThread.between(from: @from_user, to: @to_user).first
    @progress = reservation.progress_text

    # rubocop:disable Style/SymbolProc
    mail(
      to: @to_user.email,
      subject: '予約がキャンセルされました/Reservation has been canceled'
    ) do |format|
      format.text
    end
    # rubocop:enable Style/SymbolProc
  end
end
