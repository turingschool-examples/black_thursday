require 'csv'
require_relative '../lib/customer'

class CustomerRepository
  attr_reader :all

  def initialize(path)
    @all = []
    create_customer(path)
  end

  def create_customer(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      @all << Customer.new(row, self)
    end
  end

  def find_by_id(id)
    @all.find do |customer|
      customer.id == id
    end
  end

  def new_customer_id_number
    @all.max_by do |customer|
      customer.id
    end.id + 1 
  end

  def find_all_by_first_name(first_name)
    @all.find_all do |customer|
      customer.first_name == first_name
    end
  end

  def find_all_by_last_name(last_name)
    @all.find_all do |customer|
      customer.last_name == last_name
    end
  end

  def create(attributes)
    new_customer = Customer.create(attributes, self)
    @all << new_customer
  end

  def update(id, attributes)
    unless find_by_id(id).nil?
      find_by_id(id).update(attributes)
    end
  end

  def delete(id)
    @all.delete(self.find_by_id(id))
  end

  # :nocov:
  def inspect
    "#{self.class} #{@customer.size} rows"
  end
  # :nocov:
end
