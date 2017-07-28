require 'pry'
require 'csv'
require 'time'
require_relative '../lib/customer'
require_relative '../lib/file_opener'

class CustomerRepository
  include FileOpener
  attr_reader :all

  def initialize(customers, sales_engine)
    @customers = open_csv(customers)
    @se = sales_engine
    @all = @customers.map do |row|
      Customer.new(row, self)
    end
  end

  def find_by_id(id)
    @all.find do |transaction|
      transaction.id == id
    end
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

end
