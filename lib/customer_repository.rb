require 'CSV'
require_relative 'customer'

class CustomerRepository
  attr_reader :file_path, :all, :customers, :id

  def initialize(file_path, engine)
    @file_path = file_path
    @engine = engine
    @customers = []
  end

  def create_repo
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      customer = Customer.new(row, self)
      @customers << customer
    end
    self
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end

  def all
    customers
  end

  def find_by_id(id)
    customers.find do |customer|
      customer.id == id
    end
  end

  def find_all_by_first_name(first_name)
    customers.find_all do |customer|
      customer.first_name == first_name
    end
  end

  def find_all_by_last_name(last_name)
    customers.find_all do |customer|
      customer.last_name == last_name
    end
  end

  def create(attributes)
    customer_id = customers.max { |customer| customer.id}
    attributes[:id] = customer_id.id + 1
    @customers << Customer.new(attributes, self)
  end

  def update(id, attributes)
    customer_by_id = find_by_id(id)
    if customer_by_id != nil
      customer_by_id.change_first_name(attributes[:first_name])
      customer_by_id.change_last_name(attributes[:last_name])
      customer_by_id.update_time
    end
  end

  def delete(id)
    chopping_block = customers.index { |customer| customer.id == id}
    if chopping_block != nil
      customers.delete_at(chopping_block)
    end
  end
end
