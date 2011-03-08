module Ackee
  # Ackee ships with a number of useful Expression Matchers.
  # Expression Matchers are just methods that return true or raise an
  # Exception in case that the result is not the expected one.
  #
  # == Predicates
  # TODO 
  # Ackee  will  create custom Matchers on the fly for method that
  # match the regexp pattern /$be_*^/
  #
  # The first match should be a method that respond true or false to match?
  #
  #   [].should be_empty     => [].empty? #passes
  #   [].should_not be_empty => [].empty? #fails
  #
  # == Custom Matchers
  #
  # When you find that none of the stock Expectation Matchers provide a natural
  # feeling expectation, you can very easily write your own using RSpec's matcher
  # DSL or writing one from scratch.
  #
  # module Matchers
  #   def have(number)
  #     result = @not ? @object.size != number :  @object.size == number
  #     raise Exception unless result
  #     self
  #   end
  # end  
  module Matchers
    # Passes if actual and expected are the same object (object identity).
    #
    # See http://www.ruby-doc.org/core/classes/Object.html#M001057 for more information about equality in Ruby.
    #
    # == Examples
    #
    #   5.should.be.equal(5)         #Fixnums are equal
    #   "5".should.not.be.equal("5") #Strings that look the same are not the same object
    def equal(arg)
      result = @not ? @object != arg :  @object == arg
      raise Exception unless result      
    end
    
    def have(number)
      result = @not ? @object.size != number :  @object.size == number
      raise Exception unless result
      self
    end
  end
end
