
require 'time'
require 'CSV'
require 'customer'

class CustomerRepository
  attr_reader :all
  
  def initialize(path)
    @all = []

  end
end
