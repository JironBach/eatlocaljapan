class PaymentMethodsController < ApplicationController
  force_ssl if: -> { Rails.env.production? }

  before_action :authenticate_user!
  before_action :load_payment_methods, only: :index

  # HACK: need to add configuration of authentication about paymebt methods.
  authorize_resource

  def index
  end

private
  def load_payment_methods
    @instances = @payment_methods = current_user.payment_methods
  end
end
