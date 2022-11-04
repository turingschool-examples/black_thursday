require_relative 'customer'
require_relative 'modify'
require_relative 'find'

class CustomerRepository
include Find
include Modify

  attr_reader :customers
  def initialize
    @customers = []
  end

  def find_by_id(cust_id)
    @customers.find do |customer|
      customer.id == cust_id
    end
  end

  def add(customer)
    @customers << Customer.new(customer)
  end

  def all
    @customers
  end

  def find_all_by_first_name(first_name)
    @customers.find_all do |customer|
      customer.first_name == first_name
    end
  end
end