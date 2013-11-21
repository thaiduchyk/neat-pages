module NeatPages
  #*************************************************************************************
  # Error that will be raised if the page called is out of bound.
  #*************************************************************************************
  class OutOfBound < StandardError
  end

  #*************************************************************************************
  # Error that will be raised if the pagination isn't initialized
  #*************************************************************************************
  class Uninitalized < StandardError
  end
end
