module Ackee
  class Description
    def initialize(name, &block)
      @name    = name
      @block   = block
      @befores = @afters  = []
      @stats   = {:pending => 0, :success => 0, :fails => 0}
    end

    def before(&block);  @befores << block;  end    
    def after(&block);   @afters  << block;  end
    
    def it(name, &spec)      
      @befores.each { |block| instance_eval(&block)}
      
      if !block_given?
        puts "#{name} is still pending.".yellow
        @stats[:pending] += 1
      end
      
      begin      
        instance_eval(&spec)
        puts "#{@name} -- #{name}.".green
        @stats[:success] += 1
      rescue Object => e
        error = ""
        e.backtrace.find_all { |line| line !~ /ackee|\/ackee\.rb:\d+/ }. each { |line|
            error << "\t#{line}\n"
        }
        puts "#{@name} -- #{name}\n #{error}".red
        @stats[:fails]   += 1
      ensure        
        @afters.each  { |block| instance_eval(&block)}
      end
    end
        
    def run
      instance_eval(&@block)
    end
  end
  
  class Should
    include Ackee::Matchers
    
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
    alias a  be
    alias an be

    # we want the dsl to be as fluent as possible
    # but not sure how good idea is this
    def method_missing(*args);  self;  end    
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
