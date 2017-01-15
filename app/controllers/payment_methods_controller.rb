class PaymentMethodsController < ApplicationController
  before_action :authenticate_user!
  before_action :regist_member, :create_gmo_instance, :load_payment_methods, only: :index

  # HACK: need to add configuration of authentication about paymebt methods.
  authorize_resource

  def index
  end

private
  def regist_member
    redirect_to root_path, notice: I18n.t('alerts.payment_methods.index.failure', model: CreditCard.model_name.human) unless current_user.regist_member && current_user.save
  end

  def create_gmo_instance
    @gmo_request = Gmo::CheckCreditCard.new(member_id: current_user.member_id, ret_url: credit_cards_url, lang: I18n.locale == :ja ? :ja : :en)
  end

  def load_payment_methods
    @instances = @payment_methods = current_user.payment_methods
  end
end
