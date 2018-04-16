require_relative './repository'
require_relative './customer'
require 'time'

class CustomerRepository
  include Repository

  attr_reader   :repository

  def initialize(customers)
    customer_array = []
    @repository = {}
    customers.each { |customer| customer_array << Customer.new(to_customer(customer))}
    customer_array.each do |customer|
      if customer.nil?
      else
        @repository[customer.id] = customer
      end
    end
  end

  def to_customer(customer)
    customer_hash = {}
    customer.each do |line|
      customer_hash[line[0]] = line[1]
    end
    customer_hash
  end

  def find_all_by_first_name(name)
    @repository.values.find_all do |customer|
      customer.first_name == name
    end
  end

  def find_all_by_last_name(name)
    @repository.values.find_all do |customer|
      customer.last_name == name
    end
  end



end
