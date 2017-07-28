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

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def find_by_id(id)
    @all.find do |customer|
      customer.id == id
    end
  end

  def find_all_by_first_name(first_name)
    @all.find_all do |customer|
      (/#{first_name}/i) =~ customer.first_name
    end
  end

  def find_all_by_last_name(last_name)
    @all.find_all do |customer|
      (/#{last_name}/i) =~ customer.last_name
    end
  end

end
