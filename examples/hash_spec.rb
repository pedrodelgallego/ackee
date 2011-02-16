require File.expand_path(File.dirname(__FILE__)) + "/../lib/ackee"

describe Hash, "literal" do
  puts "inside of description"

  before do
    puts "inside of before"
  end
    
  it "an example" do
    puts "inside of an example"
  end
  
  it "another example" do
    puts "inside of anohter example"
  end
end
