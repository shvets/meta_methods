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

    def locals_to_hash object, content
      scope = object.instance_eval { binding }

      eval(content, scope)

      extract_values(defined_vars(scope), scope)
    end

    private

    def defined_vars scope
      eval("local_variables", scope) - Kernel.local_variables - %w(content)
    end

    def extract_values vars_list, scope
      vars_values_list = vars_list.collect { |name| [name, get_property(name, scope)] }

      hash = {}
      vars_values_list.each do |var, value|
        hash[var.to_sym] = value
      end

      hash
    end

    def get_property name, scope
      begin
        eval(name.to_s, scope)
      rescue NameError
        nil
      end
    end
  end
end