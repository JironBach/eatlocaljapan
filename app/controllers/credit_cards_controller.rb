class CreditCardsController < ApplicationController
  protect_from_forgery except: [:create]

  before_action :authenticate_user!
  before_action :load_credit_card, only: [:destroy]
  before_action :load_gmo_instance, only: [:create]

  # HACK: need to reconsider configuration of authentication about payment methods.
  authorize_resource only: [:destroy]

  def create
    respond_to do |format|
      unless @gmo_response && @gmo_response.valid? && (@gmo_request || current_user.with_lock { current_user.synchronize_credit_cards && current_user.save })
        Rails.logger.info("gmo error: #{@gmo_response.errors.join(',')}(member id: #{current_user.member_id})") unless @gmo_response.valid?
        format.html { redirect_to root_path, notice: I18n.t(:failure, model: CreditCard.model_name.human, scope: [:alerts, :credit_cards, :update]) }
      else
        if @gmo_request
          format.html { render 'create' }
        else
          format.html { redirect_to payment_methods_path, notice: I18n.t(:success, model: CreditCard.model_name.human, scope: [:alerts, :credit_cards, :update]) }
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      if current_user.with_lock { @credit_card.destroy }
        format.html { redirect_to payment_methods_path, notice: I18n.t(:success, model: CreditCard.model_name.human, scope: [:alerts, :credit_cards, :destroy]) }
      else
        format.html { redirect_to payment_methods_path, alert: I18n.t(:failure, model: CreditCard.model_name.human, scope: [:alerts, :credit_cards, :destroy]) }
      end
    end
  end

private
  def load_credit_card
    @instance = @credit_card = current_user.credit_cards.find(params[:id]).tap { |credit_card| credit_card.assign_attributes(permitted_params) }
  end

  def load_gmo_instance
    @gmo_response = \
      unless params.key?('TranID')
        Gmo::RegistCreditCardResponse.new(member_id: current_user.member_id).tap { |instance| instance.assign_attributes(permitted_regist_credit_card_response_params) }
      else
        Gmo::CheckCreditCardResponse.new(member_id: current_user.member_id).tap do |instance|
          instance.assign_attributes(permitted_check_credit_card_response_params)
          @gmo_request = \
            Gmo::RegistCreditCard.new(member_id: current_user.member_id, order_id: instance.order_id, ret_url: credit_cards_url, lang: I18n.locale == :ja ? :ja : :en)
        end
      end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def permitted_params
    params.fetch(:credit_card, {}).permit(:card_no, :expired_on)
  end

  def permitted_check_credit_card_response_params
    link = Payment.service(:gmo).link.about(:check_credit_card)
    fields = \
      [:job_cd, :amount, :access_id, :access_pass, :order_id, :forwarded, :method, :pay_times, :approve, :card_no, :tran_id, :tran_date, :check_string, :err_code, :err_info]
    params.permit(*link.attribute_mappings.invert.values_at(*fields)).transform_keys { |key| link.attribute_name(key) }
  end

  def permitted_regist_credit_card_response_params
    link = Payment.service(:gmo).link.about(:regist_credit_card)
    params.permit(*link.attribute_mappings.invert.values_at(:order_id, :check_string, :datetime, :err_code, :err_info)).transform_keys { |key| link.attribute_name(key) }
  end
end
