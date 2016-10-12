module Decoratable
  extend ActiveSupport::Concern

  included do |klass|
  end

  class_methods do
    def inherited(klass)
      super
      klass.send(:include, klass.parent.const_get(klass.name.demodulize + 'Decorator')) rescue nil
    end
  end
end
