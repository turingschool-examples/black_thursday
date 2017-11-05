require 'csv'
require_relative '../lib/customer'
require_relative '../lib/create_elements'

class CustomerRepository

  include CreateElements

  attr_reader :customers, :engine

  def initialize(customer_file, engine)
    @customers = create_elements(customer_file).map {|customer|
      Customer.new(customer, self)}
    @engine   = engine
  end

  def all
    return customers
  end


end
