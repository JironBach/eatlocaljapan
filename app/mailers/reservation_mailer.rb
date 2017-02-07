class ReservationMailer < ApplicationMailer
  def send_new_reservation_notification(reservation)
    @locale = I18n.locale

    from_user = User.find(reservation.guest_id)
    @from_user_name = "#{from_user.profile.last_name} #{from_user.profile.first_name}"
    to_user = User.find(reservation.host_id)
    @to_user_name = "#{to_user.profile.last_name} #{to_user.profile.first_name}"

    # rubocop:disable Style/SymbolProc
    mail(
      to:      to_user.email,
      subject: '新しい予約/New Reservation'
    ) do |format|
      format.text
    end
    # rubocop:enable Style/SymbolProc
  end

  def send_update_reservation_notification(reservation, from_user_id)
    @locale = I18n.locale

    if from_user_id == reservation.guest_id
      to_user_id = reservation.host_id
      @dest = 'host'
    elsif from_user_id == reservation.host_id
      to_user_id = reservation.guest_id
      @dest = 'guest'
    end

    from_user = User.find(from_user_id)
    @from_user_name = "#{from_user.profile.last_name} #{from_user.profile.first_name}"
    to_user = User.find(to_user_id)
    @to_user_name = "#{to_user.profile.last_name} #{to_user.profile.first_name}"

    @message_thread = MessageThread.between(from: from_user, to: to_user).first

    @progress = reservation.progress_text

    # rubocop:disable Style/SymbolProc
    mail(
      to:      to_user.email,
      subject: '予約がキャンセルされました/Reservation has been canceled'
    ) do |format|
      format.text
    end
    # rubocop:enable Style/SymbolProc
  end
end
