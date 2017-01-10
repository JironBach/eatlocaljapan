class CreditCardsController < ApplicationController
  force_ssl if: -> { Rails.env.production? }

  before_action :authenticate_user!
  before_action :load_credit_card, only: [:edit, :update, :destroy]
  before_action :create_credit_card, only: [:new, :create]

  # HACK: need to reconsider configuration of authentication about payment methods.
  authorize_resource

  def new
  end

  def edit
  end

  def create
    respond_to do |format|
      if current_user.with_lock { @credit_card.save }
        format.html { redirect_to payment_methods_path, notice: I18n.t(:success, model: CreditCard.model_name.human, scope: [:alerts, :credit_cards, :create]) }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if current_user.with_lock { @credit_card.save }
        format.html { redirect_to payment_methods_path, notice: I18n.t(:success, model: CreditCard.model_name.human, scope: [:alerts, :credit_cards, :update]) }
      else
        format.html { render :edit }
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

  def create_credit_card
    @instance = @credit_card = current_user.credit_cards.build(permitted_params)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def permitted_params
    params.fetch(:credit_card, {}).permit(:card_no1, :card_no2, :card_no3, :card_no4, :expired_year, :expired_month)
  end
end
