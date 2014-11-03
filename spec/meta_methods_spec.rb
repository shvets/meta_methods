require 'meta_methods/core'

class MetaMethodsDemo
  include MetaMethods::Core
end

describe MetaMethodsDemo do
  describe "#define_attribute" do
    it "creates new attribute on object" do
      object = Object.new

      subject.define_attribute object, :new_attribute, "new_attribute_value"

      expect(object.new_attribute).to eq("new_attribute_value")
    end
  end

  describe "#define_attributes" do
    it "creates new attributes on object" do
      object = Object.new

      subject.define_attributes(object,
                                {new_attribute1: "new_attribute_value1",
                                 new_attribute2: "new_attribute_value2" })

      expect(object.new_attribute1).to eq("new_attribute_value1")
      expect(object.new_attribute2).to eq("new_attribute_value2")
    end
  end

  describe "#locals_to_hash" do
    it "should evaluate content" do
      s = "a=1; b=2"

      hash = subject.locals_to_hash subject, s

      expect(hash[:a]).to eq 1
      expect(hash[:b]).to eq 2
      expect(hash[:c]).to be_nil
    end
  end

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
