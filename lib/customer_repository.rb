require 'bigdecimal'
require 'bigdecimal/util'
require_relative 'repository'

class CustomerRepository
  include Repository

  def initialize(customers)
    @list = customers
  end

end
