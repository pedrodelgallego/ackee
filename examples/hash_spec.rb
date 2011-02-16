require File.expand_path(File.dirname(__FILE__)) + "/../lib/ackee"

describe Hash, "literal" do
  puts "inside of description"

  before do
    puts "inside of before"
    @name = "Pedro Del Gallego"
  end

  after do
    puts "inside of after"
  end
  
  it "an example" do
    puts "inside of an example name #{@name}"
  end
  
  it "another example" do
    puts "inside of anohter example"
  end  
end
