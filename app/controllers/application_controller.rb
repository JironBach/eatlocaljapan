class ApplicationController < ActionController::Base
  load_and_authorize_resource

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  # before_action :set_default_locale
  before_action :set_locale

  # Using cancancan
  # watch app/models/ability.rb
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_url, alert: Settings.regulate_user.cancan.failure }
      format.json { head :no_content  }
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    EasyTranslate.api_key = ENV['GOOGLE_TRANSLATE_KEY']
  end

  def default_url_options(options={})
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end

  def authenticate_user?
    authenticate_user! or current_user.admin?
  end
end
