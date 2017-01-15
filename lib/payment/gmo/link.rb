class Payment
  class Gmo
    class Link < Base
      autoload :CreditCard
      autoload :CheckCreditCard
      autoload :RegistCreditCard

      class << self
        def about(about=:credit_card)
          const_get(about.to_s.classify).tap { |klass| yield(klass) if block_given? }
        end
      end

      class Base < Payment::Gmo::Base
        attr_accessor :link, :url

        class << self
          def encode(*args)
            Digest::MD5.hexdigest(args.join)
          end

          def param_name(field)
            Settings.gmo.link.params[name.demodulize.underscore][field]
          end

          def attribute_mappings
            Settings.gmo.link.params["#{name.demodulize.underscore}_response"].to_h.invert
          end

          def attribute_name(param_name)
            attribute_mappings[param_name]
          end
        end

        def digest(*args)
          self.class.digest(*args)
        end

        def param_name(field)
          self.class.param_name(field)
        end

        def attribute_mappings
          self.class.attribute_mappings
        end

        def attribute_name(param_name)
          self.class.attribute_name(param_name)
        end
      end
    end
  end
end
