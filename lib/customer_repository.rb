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
    all.find_all do |customer|
      customer.first_name.upcase.include?(first_name.upcase)
    end
  end

  def find_all_by_last_name(last_name)
    all.find_all do |customer|
      customer.last_name.upcase.include?(last_name.upcase)
    end
  end

  def create(info)
    info[:id] = find_new_id
    customer = Customer.new(info)
    add_customer(customer)
  end

  def update(id, attributes)
    customer = find_by_id(id)
    return nil if customer == nil
    customer.first_name = attributes[:first_name] if attributes.has_key?(:first_name)
    customer.last_name = attributes[:last_name] if attributes.has_key?(:last_name)
    customer.updated_at = Time.now
  end
end
