module BetterEnum
  extend ActiveSupport::Concern

  included do |klass|
  end

  class_methods do
    def enum(definitions)
      super
      klass = self
      definitions.each do |name, values|
        enum_values = klass.send(name.to_s.pluralize)
        klass.singleton_class.send(:define_method, :"#{name}_text") { |value| I18n.t(value, default: value.to_s, scope: [:enum, klass.name.underscore.to_sym, name]) }
        _enum_methods_module.module_eval do
          define_method(:"#{name}_text") { I18n.t((value = send(name).to_sym), default: value.to_s, scope: [:enum, klass.name.underscore.to_sym, name]) }
          define_method(:"#{name}_value") { enum_values[send(name)] }
        end
      end
    end
  end
end
