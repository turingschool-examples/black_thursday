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

  def find_by_id(id)
    customers.find do |customer|
      customer.id == id
    end
  end

  def find_all_by_first_name(first_name)
    customers.find_all do |customer|
      customer.first_name.downcase.include?(first_name.downcase)
    end
  end

  def find_all_by_last_name(last_name)
    customers.find_all do |customer|
      customer.last_name.downcase.include?(last_name.downcase)
    end
  end

  def find_merchants_by_customer_id(id)
    engine.find_merchants_by_customer_id(id)
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end

end
