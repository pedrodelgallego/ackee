require 'rubygems'
require 'terminal-display-colors'

module Ackee
  class Description
    def initialize(name, &block)
      @name    = name
      @befores = []
      @afters  = []
      @block   = block
      @stats   = {:pending => 0, :success => 0, :fails => 0}
    end

    def before(&block);  @befores << block;  end    
    def after(&block);   @afters  << block;  end

    class PendingExampleError < Exception ; end
    
    def it(name, &spec)
      begin
        raise PendingExampleError if !block_given?
        @befores.each { |block| instance_eval(&block)}
        instance_eval(&spec)      
        @afters.each  { |block| instance_eval(&block)}
      rescue PendingExampleError        
        puts "#{name} is still pending ".yellow
        @stats[:pending] += 1
      rescue Object => e
        puts "#{e.inspect}"
      end
    end
        
    def run
      instance_eval(&@block)
    end
  end

  class Should
    def initialize(object)
      @object = object
      @not    = false
    end

    def not
      @not = !@not
      self
    end
        
    def be(arg=nil)
      arg.nil? ? self :  equal(arg)
    end

    def equal(arg)
      result = @not ? @object != arg :  @object == arg
      raise Exception unless result        
    end
    
    alias a  be
    alias an be    
  end  
end

class Object
  def should(*args, &block)
    Ackee::Should.new(self)
  end
end

Kernel.send :define_method, :describe do |*args, &block|
  Ackee::Description.new(args.join(' '), &block).run
end
