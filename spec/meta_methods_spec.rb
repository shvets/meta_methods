require 'meta_methods'

class MetaMethodsDemo
  include MetaMethods
end

describe MetaMethodsDemo do

  it "should evaluate content" do
    s = "a=1; b=2"

    hash = subject.locals_to_hash subject, s

    hash[:a].should == 1
    hash[:b].should == 2
    hash[:c].should be_nil
  end
end
