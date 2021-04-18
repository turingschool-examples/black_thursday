require 'CSV'
require 'time'
require 'item'
require_relative 'customer'

class CustomerRepo
  attr_reader :customers

  def initialize(path)
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

  def find_by_id(id)
    @customers.find do |customer|
      customer.id == id
    end
  end

  def find_all_by_first_name(name_fragment)
    @customers.find_all do |customer|
      customer.first_name.include?(name_fragment)
    end
  end

  def find_all_by_last_name(name_fragment)
    @customers.find_all do |customer|
      customer.last_name.include?(name_fragment)
    end
  end

  def create(attributes)
    customer = Customer.new(attributes, @engine)
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
