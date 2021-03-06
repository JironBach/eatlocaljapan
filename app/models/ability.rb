class Ability
  include CanCan::Ability

  def initialize(user)
    # How to use
    # https://github.com/CanCanCommunity/cancancan/wiki/defining-abilities

    user ||= User.new # guest user (not logged in)

    alias_action :index, :show, :search, to: :read
    alias_action :new, to: :create
    alias_action :edit, :destroy, to: :update
    alias_action :publish, :unpublish, to: :update
    alias_action :manage, to: :update
    alias_action :create, :read, :update, :destroy, to: :crud

    # All
    can [:read, :create], :all

    can [:update], :all if user.admin?

    # Listing Resources
    models = [Listing]
    can [:update], models do |listing|
      listing.user_id == user.id
    end
    models = [ListingImage, DressCode, Confection, Tool, UserNgevent]
    can [:update], models do |related|
      related.listing.user_id == user.id
    end

    # User related Resources
    models = [Profile, ProfileImage, PaymentMethod, CreditCard]
    can [:update], models do |related|
      related.user_id == user.id
    end

    # Two User's Resources
    models = [Reservation]
    can [:update], models do |model|
      Rails.logger.info(model)
      model.host_id == user.id || model.guest_id == user.id
    end
  end
end
