module Ackee
  class Description
    def initialize(name, &block)
      @name    = name
      @befores = []
      @afters  = []
      @block   = block
    end

    def before(&block);  @befores << block;  end    
    def after(&block);   @afters  << block;  end
    
    def it(name, &spec)
      @befores.each { |block| instance_eval(&block)}
      instance_eval(&spec)      
      @afters.each  { |block| instance_eval(&block)}
    end
        
    def run
      instance_eval(&@block)
    end
  end  
end

Kernel.send :define_method, :describe do |*args, &block|
  Ackee::Description.new(args.join(' '), &block).run
end  

