require_relative 'customer'
require 'time'
require "csv"

class CustomerRepository
  attr_reader :filename,
              :parent,
              :customers

  def initialize(filename, parent)
    @filename = filename
    @parent = parent
    @customers = Array.new
    generate_customers(filename)
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end

  def generate_customers(filename)
    customers = CSV.open filename, headers: true, header_converters: :symbol
    customers.each do |row|
      @customers << Customer.new(row, self)
    end
  end

  def all
    @customers
  end

  def find_by_id(id)
    @customers.find_all do |customer|
      customer.id.to_s == id
    end
  end

  def find_all_by_first_name(first_name)
    @customers.find_all do |customer|
     customer.first_name.to_s == first_name
    end
  end

  def find_all_by_last_name(last_name)
    @customers.find_all do |customer|
     customer.last_name.to_s == last_name
    end
  end

  def create(attributes)
    id = @customers[-1].id.to_i
    id += 1
    id = id.to_i
    attributes[:id] = id
    customer = customer.new(attributes, self)
    @customers << customer
  end

  def update(id, attributes)
    update_customer = find_by_id(id)
    update_customer.update(attributes) if !attributes[:first_name].nil?
    update_customer.update(attributes) if !attributes[:last_name].nil?
    update_customer
  end

  def delete(id)
    delete = find_by_id(id)
    @customers.delete(delete)
  end
end
