class MessageMailer < ApplicationMailer
  def send_new_message_notification(message_thread, message_params)
    @locale = I18n.locale
    @message_thread = message_thread
    from_user = User.find(message_params['from_user_id'])
    @from_user_name = "#{from_user.profile.last_name} #{from_user.profile.first_name}"
    to_user = User.find(message_params['to_user_id'])
    @to_user_name = "#{to_user.profile.last_name} #{to_user.profile.first_name}"
    # rubocop:disable Style/SymbolProc
    mail(
      to:      to_user.email,
      subject: '新しいメッセージが届きました/You received a new message'
    ) do |format|
      format.text
    end
    # rubocop:enable Style/SymbolProc
  end
end
