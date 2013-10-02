module MetaMethods
  def metaclass object
    class << object
      self
    end
  end

  def define_attributes(type, object, hash, create_instance=true)
    hash.each_pair do |key, value|
      define_attribute(type, object, key, value, create_instance)
    end
  end

  def define_attribute(type, object, key, value, create_instance=true)
    if create_instance
      metaclass(object).send type, key.to_sym

      object.instance_variable_set("@#{key}".to_sym, value)
    else
      metaclass(object).class_eval <<-CODE
        def #{key}
          "#{value}"
        end
      CODE
    end
  end

  def locals_to_hash object, content
    scope = object.instance_eval { binding }

    eval(content, scope)

    extract_values(defined_vars(scope), scope)
  end

  def evaluate_dsl(create_block, destroy_block, execute_block)

    begin
      created_object = create_block.kind_of?(Proc) ? create_block.call : create_block

      created_object.instance_variable_set(:@parent, block_parent(execute_block))

      def created_object.method_missing(sym, *args, &block)
        @parent.send sym, *args, &block
      end

      def created_object.respond_to?(sym, include_private = false)
        @parent.respond_to? sym, include_private
      end

      created_object.instance_eval(&execute_block)
    ensure
      destroy_block.call(created_object) if destroy_block && created_object
    end
  end

  def block_parent block
    block_binding = block.binding

    block_binding.eval 'self'
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