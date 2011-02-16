Ackee.
====== 

A small rspec-like testing framework. 

An quick tour.
 
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
      
      it "checks duplicated keys on initialization" do
        h = {:foo => :bar, :foo => :foo}
        h.keys.size.should == 1
        h.should == {:foo => :foo}
      end
    end
