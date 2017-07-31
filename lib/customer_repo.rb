require_relative 'customer'
require 'csv'
require 'pry'

class CustomerRepository
  attr_reader :customers, :engine

  def initialize(csvfile, engine)
    @engine    = engine
    @customers = create_hash_of_customers(csvfile)
  end

  def create_hash_of_customers(csvfile)
    all_customers = {}
    csvfile.each do |row|
      all_customers[row[:id]] = Customer.new(row, self)
    end
    all_customers
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def all
    @customers.values
  end

  def find_by_id(customer_id)
    @customers[customer_id.to_s]
  end

  def find_all_by_first_name(first_name)
    all.find_all do |customer|
      customer.first_name.downcase.include?(first_name.downcase)
    end
  end

  def find_all_by_last_name(last_name)
    all.find_all do |customer|
      customer.last_name.downcase.include?(last_name.downcase)
    end
  end

  # def find_merchants_by_customer_id(customer_id)
  #   @engine.find_merchants_by_customer_id(customer_id)
  # end

  def find_merchants_by_customer_id(customer_ids)
    all.find_all do |customer|
      customer_ids.include?(customer.id)
    end
  end


end
