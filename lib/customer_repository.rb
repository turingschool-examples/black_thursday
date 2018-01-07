require 'csv'
require 'pry'
require_relative '../lib/customer'
require_relative '../lib/csv_parser'

class CustomerRepository

  include CsvParser

  attr_reader :customers,
              :se

  def initialize(csv_file, se)
    @customers = []
    @se = se
    parser(csv_file).each { |row| @customers << Customer.creator(row, self) }
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end

  def all
    @customers
  end

  def find_by_id(id)
    @customers.find do |customer|
      customer.id == id
    end
  end

  def find_all_by_first_name(name)
    customers.find_all do |customer|
      customer.first_name == name
    end
  end

  def find_all_by_last_name(name)
    customers.find_all do |customer|
      customer.last_name == name
    end
  end

end
