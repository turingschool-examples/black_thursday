require 'csv'
require_relative 'customer'

# This is an customer repository class
class CustomerRepository
  attr_reader :parent, :customers

  def initialize(customer_csv, parent)
    @parent = parent
    @customers = []

    csv_file = CSV.open(customer_csv, headers: true, header_converters: :symbol)
    csv_file.each do |row|
      @customers << Customer.new(row, self)
    end
  end

  def all
    @customers
  end

  def find_by_id(id)
    @customers.find { |customer| customer.id == id.to_i }
  end

  def find_all_by_first_name(first_name)
    @customers.find_all do |customer|
      customer.first_name.downcase.include?(first_name.downcase)
    end
  end

  def find_all_by_last_name(last_name)
    @customers.find_all do |customer|
      customer.last_name.downcase.include?(last_name.downcase)
    end
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end
end
