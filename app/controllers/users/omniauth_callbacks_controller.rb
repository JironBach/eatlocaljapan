class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      handle_redirect('devise.facebook_data', 'Facebook', @user)
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def handle_redirect(_session_variable, kind, user)
    I18n.locale = session[:omniauth_login_locale] || I18n.default_locale
    sign_in_and_redirect user, event: :authentication
    set_flash_message(:notice, :success, kind: kind) if is_navigational_format?
  end

end
