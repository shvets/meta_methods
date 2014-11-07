require 'meta_methods/core'

describe MetaMethods::Core do
  let(:subject) { MetaMethods::Core.instance }

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

  describe "#block_to_hash" do
    it "should evaluate content" do
      content = "a=1; b=2"

      hash = subject.block_to_hash content

      expect(hash[:a]).to eq 1
      expect(hash[:b]).to eq 2
      expect(hash[:c]).to be_nil
    end
  end

end
