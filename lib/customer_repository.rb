require_relative 'customer'
require          'pry'

class CustomerRepository
  attr_reader :customers

  def initialize(csv_hash)
    @customers = csv_hash.map {|csv_hash| Customer.new(csv_hash) }
  end

  def all
    customers
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def find_by_id(customer)
    customers.find {|cust| cust.id == customer.to_i}
  end

  def find_all_by_first_name(customer)
    customers.find_all {|cust| cust.first_name== customer}
  end

  def find_all_by_last_name(customer)
    customers.find_all { |cust| cust.last_name == customer}
  end

end
