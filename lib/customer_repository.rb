require_relative './repository'
require_relative './customer'

class CustomerRepository < Repository
  attr_reader :collection

  def initialize
    @collection = {}
  end

  def add_customer(customer)
    @collection[customer.id] = customer
  end

  def find_all_by_first_name(first_name)
    all.find_all { |customer| customer.first_name == first_name }
  end

  def find_all_by_last_name(last_name)
    all.find_all { |customer| customer.last_name == last_name }
  end

  def create(info)
    info[:id] = find_new_id
    customer = Customer.new(info)
    add_customer(customer)
  end

  def update(id, attributes)
    customer = find_by_id(id)
    customer.first_name = attributes[:first_name] if attributes.has_key?(:first_name)
    customer.last_name = attributes[:last_name] if attributes.has_key?(:last_name)
  end
end
