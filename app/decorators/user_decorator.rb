module UserDecorator
  extend ActiveSupport::Concern

  included do |klass|
    klass.send(:delegate, :full_name, to: :profile, allow_nil: true)
  end
end