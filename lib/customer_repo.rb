require 'CSV'
require 'time'
require 'item'
require_relative 'customer' 
require_relative 'findable'

class CustomerRepo
  include Findable
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

  def create(attributes)
    customer = Customer.new(attributes, self)
    max = @customers.max_by do |customer|
      customer.id
    end
    customer.update_id(max.id)
    @customers << customer
    customer
  end

  def update(id, attributes)
    customer = find_by_id(id, @customers)
    return if !customer
    customer.update_all(attributes)
  end

  def delete(id)
    @customers.delete(find_by_id(id, @customers))
  end
end
