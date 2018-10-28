require 'time'
require_relative '../lib/customer'
require_relative '../lib/repository'

class CustomerRepository
  include Repository

  def initialize(customers)
    @collection = customers
  end


end
