class MessageMailer < ApplicationMailer
  def send_new_message_notification(message_thread, message_params)
    @locale = I18n.locale
    @message_thread = message_thread
    @from_user, @to_user = ['from_user_id', 'to_user_id'].map { |param_name| User.find(message_params[param_name]) }

    # rubocop:disable Style/SymbolProc
    mail(
      to: @to_user.email,
      subject: '新しいメッセージが届きました/You received a new message'
    ) do |format|
      format.text
    end
    # rubocop:enable Style/SymbolProc
  end
end
