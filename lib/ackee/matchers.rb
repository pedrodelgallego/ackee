module Ackee 
  module Matchers
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
