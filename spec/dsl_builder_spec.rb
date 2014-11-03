require 'meta_methods/dsl_builder'

describe MetaMethods::DslBuilder do
  let(:subject) { MetaMethods::DslBuilder.instance }

  describe "#evaluate_dsl" do
    it "calls all lambdas" do
      create_block = lambda { created }
      destroy_block = lambda {|object| p destroyed(object) }

      execute_block = lambda {|object| p executed(object) }

      subject.evaluate_dsl(create_block, destroy_block, execute_block)
    end
  end

  private

  def created
    p "created"
  end

  def destroyed object
    p "destroyed: #{object}"
  end

  def executed object
    p "executed: #{object}"
  end
end
