require 'bigdecimal'
require 'bigdecimal/util'
require_relative 'repository'

class CustomerRepository
  include Repository

  def initialize(customers)
    @list = customers
  end

  def find_all_by_first_name(name)
    @list.find_all do |customer|
      customer.first_name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_last_name(name)
    @list.find_all do |customer|
      customer.last_name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)
    highest_customer_id = find_highest_id
    attributes[:id] = highest_customer_id.id + 1
    @list << Customer.new(attributes)
  end
end
