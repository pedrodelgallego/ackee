require File.expand_path(File.dirname(__FILE__)) + "/../lib/ackee"

describe Hash, "literal" do
  before do
    @hash = {}
  end

  it "a pending example"

  it " true == false should fails" do
    true.should.be false
  end  
  
  it " 0/0 should fails" do
    0/0
  end  

  it "{} should return an empty hash" do
    @hash.size.should.be 0
    @hash.should.be({})
  end

  it "should store elements" do
    @hash[:hello] = "hola"
    @hash.should.not.be({})    
    @hash.should.have(1).element    
  end

end
