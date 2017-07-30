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
    array_of_matching_first_names = []
    all.find_all do |customer|
      if customer.first_name.downcase == first_name.downcase
        array_of_matching_first_names << customer
      end
    end
  end

  def find_all_by_last_name(last_name)
    array_of_matching_last_names = []
    all.find_all do |customer|
      if customer.last_name.downcase == last_name.downcase
        array_of_matching_last_names << customer
      end
    end
  end

end
