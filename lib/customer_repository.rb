require_relative 'customer'

class CustomerRepository
  attr_reader :customers

  def initialize
    @customers = []
  end
end