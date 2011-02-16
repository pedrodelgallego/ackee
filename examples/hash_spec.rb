require File.expand_path(File.dirname(__FILE__)) + "/../lib/ackee"

describe Hash, "literal" do
  before do
    @hash = {}
  end

  it "a pending example"

  it "{} should return an empty hash" do
    @hash.size.should.be 0
    @hash.should.be({})
  end

  it "should store elements" do
    @hash[:hello] = "hola"
    @hash.should.not.be({})
    @hash.should.have(1).element
  end
  
  it "checks duplicated keys on initialization" do
    h = {:foo => :bar, :foo => :foo}
    h.keys.size.should == 1
    h.should == {:foo => :foo}
  end
end
