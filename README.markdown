Ackee.
====== 

A small rspec-like testing framework. 

The DSL 
=======

The description
---------------- 

An quick tour. 

    describe "Hash literal" do
      before do
        @hash = {}
      end
      
      it "{} should return an empty hash" do
        @hash.size.should == 0
        @hash.should == {}
      end
      
      it "checks duplicated keys on initialization" do
        h = {:foo => :bar, :foo => :foo}
        h.keys.size.should == 1
        h.should == {:foo => :foo}
      end
    end
     
    describe "Ruby numbers in various ways" do
      it "the standard way" do
        435.should == 435
      end
     
      it "with underscore separations" do
        4_35.should == 435
      end
      
      it "with decimals but no integer part should be a SyntaxError" do
        lambda { eval(".75")  }.should raise_error(SyntaxError)
        lambda { eval("-.75") }.should raise_error(SyntaxError)
      end
    end
