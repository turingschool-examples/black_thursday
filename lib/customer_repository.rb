require_relative './repository'

class CustomerRepository < Repository
  attr_reader :collection

  def initialize
    @collection = {}
  end

  def add_customer(customer)
    @collection[customer.id] = customer
  end


end
