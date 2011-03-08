# Ackee -- A tini tiny RSpec clone.
#
# Copyright (C) 2011 Pedro Del Gallego
#
# This software is freely distributable under the terms of an MIT-style license.
# See http://www.opensource.org/licenses/mit-license.php.

module Ackee
  VERSION = "0.2"
  
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
      else      
        begin      
          instance_eval(&spec)
          puts "#{@name} -- #{name}.".green
          @stats[:success] += 1
        rescue Object => e
          error = e.backtrace.find_all { |line| line !~ /ackee|\/ackee\.rb:\d+/ }.inject("") do |msg, line| 
            "\t#{line}\n"
          end
          puts "#{@name} -- #{name}\n #{error}".red
          @stats[:fails]   += 1
        ensure        
          @afters.each  { |block| instance_eval(&block)}
        end
      end
    end
        
    def run
      instance_eval(&@block)
    end
  end
  
  class Should
    # We remove this methods from this class so we can start with a
    # clean sheet.     
    # Kills ==, ===, =~, eql?, equal?, frozen?, instance_of?, is_a?,
    # kind_of?, nil?, respond_to?, tainted?
    instance_methods.each { |name| undef_method name  if name =~ /\?|^\W+$/ }    
    
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
  # Creates and returns a class Description. It is the main point of
  # Entrance in a test group
  #
  # It is also possible to Pass, several parameters they will create a 
  # be joined to create a complete group test name.
  #
  #   describe "Person", "that speak spanish" do ...
  #
  Ackee::Description.new(args.join(' '), &block).run
end
