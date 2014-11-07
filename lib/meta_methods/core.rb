require 'singleton'

module MetaMethods
  class Core
    include Singleton

    def define_attribute(object, key, value)
      object.singleton_class.send :attr_accessor, key.to_sym # creates accessor

      object.send "#{key}=".to_sym, value  # sets up value for attribute
    end

    def define_attributes(object, hash)
      hash.each_pair do |key, value|
        define_attribute(object, key, value)
      end
    end

    def block_to_hash content
      object = Object.new
      scope = object.send :binding

      object.send(:eval, content, scope)

      vars_list = defined_vars(object, scope) - [:content, :vars_list]

      extract_values(vars_list, object, scope)
    end

    private

    def defined_vars object, scope
      object.send(:eval, "local_variables", scope) - Kernel.local_variables
    end

    def extract_values vars_list, object, scope
      vars_values_list = vars_list.collect do |name|
        value = begin
          get_property(object, name, scope)
        rescue NameError
          nil
        end

        [name, value]
      end

      hash = {}
      vars_values_list.each do |var, value|
        hash[var.to_sym] = value
      end

      hash
    end

    def get_property object, name, scope
      object.send :eval, name.to_s, scope
    end
  end
end