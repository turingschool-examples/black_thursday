require 'CSV'
require 'time'
require 'item'
require_relative 'customer' #is this necessary
require_relative 'findable'
include Findable

class CustomerRepo
  attr_reader :customers,
              :engine

  def initialize(path, engine)
    @customers = []
    @engine = engine
    populate_information(path)
  end

  def populate_information(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |customer_info|
      @customers << Customer.new(customer_info, self)
    end
  end

  def all
    @customers
  end

  def add_customer(customer)
    @customers << customer
  end

  def create(attributes)
    customer = Customer.new(attributes, self)
    max = @customers.max_by do |customer|
      customer.id
    end
    customer.id = max.id + 1
    add_customer(customer)
    return customer
  end

  def update(id, attributes)
    new_customer = find_by_id(id)
    return if !new_customer
    new_customer.first_name = attributes[:first_name] if attributes[:first_name]
    new_customer.last_name = attributes[:last_name] if attributes[:last_name]
    new_customer.updated_at = Time.now
    return new_customer
  end

  def delete(id)
    @customers.delete(find_by_id(id))
  end

end
