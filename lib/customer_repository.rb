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

  def find_all_by_first_name(name_frag)
    @customers.find_all do |customer|
     customer.first_name.downcase.include?(name_frag.downcase)
    end
  end

  def find_all_by_last_name(name_frag)
    @customers.find_all do |customer|
     customer.last_name.downcase.include?(name_frag.downcase)
    end
  end

  def create(attributes)
    create_overall(@customers, attributes)
  end

  def delete(id)
    delete_overall(@customers, id)
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end
end