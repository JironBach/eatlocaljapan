class ApplicationRecord < ActiveRecord::Base
  include Decoratable
  include BetterEnum

  self.abstract_class = true

  class << self
    def inherited(klass)
      super
    end
  end
end
