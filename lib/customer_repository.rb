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

  def update(id, attributes)
    if find_by_id(id)
      if attributes[:first_name]
        find_by_id(id).first_name = attributes[:first_name]
      end
      if attributes[:last_name]
        find_by_id(id).last_name = attributes[:last_name]
      end
      find_by_id(id).updated_at = Time.now
    end
  end
end
