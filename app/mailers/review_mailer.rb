class ReviewMailer < ApplicationMailer

  def send_review_notification(reservation)
    @reservation = reservation
    @listing = reservation.listing
    to_user = User.find(reservation.guest_id)
    @to_user_name = "#{to_user.profile.last_name} #{to_user.profile.first_name}"
    host_user = User.find(reservation.host_id)
    @host_user_name = "#{host_user.profile.last_name} #{host_user.profile.first_name}"
    mail(
      to:      to_user.email,
      subject: I18n.t('review_mailer.send_review_mail.subject')
    ) do |format|
      format.text
    end
  end

  def send_review_reply_notification(reservation, review)
    @reservation = reservation
    @review = review
    @listing = reservation.listing
    to_user = User.find(reservation.host_id)
    @to_user_name = "#{to_user.profile.last_name} #{to_user.profile.first_name}"
    guest_user = User.find(reservation.guest_id)
    @guest_user_name = "#{guest_user.profile.last_name} #{guest_user.profile.first_name}"
    mail(
      to:      to_user.email,
      subject: I18n.t('review_mailer.send_review_reply_mail.subject')
    ) do |format|
      format.text
    end
  end
end
