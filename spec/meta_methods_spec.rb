require 'meta_methods'

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

      subject.define_attributes object,
                                {new_attribute1: "new_attribute_value1",
                                 new_attribute2: "new_attribute_value2" }

      expect(object.new_attribute1).to eq("new_attribute_value1")
      expect(object.new_attribute2).to eq("new_attribute_value2")
    end
  end

  describe "#locals_to_hash" do
    it "should evaluate content" do
      s = "a=1; b=2"

      hash = subject.locals_to_hash subject, s

      hash[:a].should == 1
      hash[:b].should == 2
      hash[:c].should be_nil
    end
  end
end
