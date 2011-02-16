module Ackee
  class Description
    def initialize(name, &block)
      @name    = name
      @befores = []
      @block   = block
    end

    def before(&block)
      @befores << block
    end    

    def it(name, &spec)
      @befores.each { |block| instance_eval(&block)}
      instance_eval(&spec)
    end
        
    def run
      instance_eval(&@block)
    end
  end
end

Kernel.send :define_method, :describe do |*args, &block|
  Ackee::Description.new(args.join(' '), &block).run
end  

