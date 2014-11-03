require 'singleton'

module MetaMethods
  class DslBuilder
    include Singleton

    def evaluate_dsl(create_block, destroy_block, execute_block, parent_name="parent")
      begin
        created_object = create_block.kind_of?(Proc) ? create_block.call : create_block

        created_object.instance_variable_set("@#{parent_name}".to_sym, context_parent(execute_block))

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

    def context_parent block
      block_binding = block.binding

      block_binding.eval 'self'
    end

  end
end
