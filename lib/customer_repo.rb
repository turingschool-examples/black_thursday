require 'CSV'
require_relative './customer'

class CustomerRepository

  attr_reader :engine, :data
  attr_accessor :customers
  def initialize(file = './data/customers.csv', engine)
    @engine = engine
    @file = file
    @customers = {}
    build_customers(CSV.readlines(@file, headers: true, header_converters: :symbol))
  end

  def build_customers(data)
    data.each do |row|
      customers[row[:id].to_i] = Customer.new({id: row[:id].to_i,
                                                  first_name: row[:first_name],
                                                  last_name: row[:last_name],
                                                  created_at: row[:created_at].to_i,
                                                  updated_at: row[:updated_at].to_i})
    end
  end

  def all
    customers.values
  end
  
  def find_by_id(id)
    customers[id]
  end

  def find_all_by_first_name(name)
    all.find_all do |customer| 
      customer.first_name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_last_name(name)
    all.find_all do |customer| 
      customer.last_name.downcase.include?(name.downcase)
    end
  end

  def max_id
    customers.keys.max
  end

  def create(attributes)
    new = Customer.new(attributes)
    new.id = (max_id + 1)
    customers[new.id] = new
  end

  def update(id, attributes)
    if attributes.keys.include?(:first_name) == true && attributes.keys.include?(:last_name) == true
      customers[id].first_name = attributes[:first_name]
      customers[id].last_name = attributes[:last_name]
      customers[id].updated_at = Time.now
    elsif attributes.keys.include?(:first_name) == true
      customers[id].first_name = attributes[:first_name]
      customers[id].updated_at = Time.now
    elsif attributes.keys.include?(:last_name) == true
      customers[id].last_name = attributes[:last_name]
      customers[id].updated_at = Time.now
    end
  end
end