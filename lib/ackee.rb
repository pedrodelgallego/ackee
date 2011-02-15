module Ackee
  class Description
    def initialize(name, &block)
      @name = name
      @block = block
    end
    
    def run
      instance_eval(&@block)
    end
  end
end

Kernel.send :define_method, :describe do |*args, &block|
  Ackee::Description.new(args.join(' '), &block).run
end  

describe Hash, "literal" do
  puts "hash literal"
end

