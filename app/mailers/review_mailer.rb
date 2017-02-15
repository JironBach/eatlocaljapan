class ReviewMailer < ApplicationMailer
  def send_review_notification(reservation)
    @reservation = reservation
    @listing = reservation.listing
    @to_user, @host_user = [:guest, :host].map { |user_type| reservation.send(user_type) }

    # rubocop:disable Style/SymbolProc
    mail(
      to: @to_user.email,
      subject: I18n.t('review_mailer.send_review_mail.subject')
    ) do |format|
      format.text
    end
    # rubocop:enable Style/SymbolProc
  end

  def send_review_reply_notification(reservation, review)
    @reservation = reservation
    @review = review
    @listing = reservation.listing
    @to_user, @guest_user = [:host, :guest].map { |user_type| reservation.send(user_type) }

    # rubocop:disable Style/SymbolProc
    mail(
      to: @to_user.email,
      subject: I18n.t('review_mailer.send_review_reply_mail.subject')
    ) do |format|
      format.text
    end
    # rubocop:enable Style/SymbolProc
  end
end
