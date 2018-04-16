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




end
