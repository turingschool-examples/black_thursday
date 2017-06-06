require 'csv'
require_relative '../lib/customer'
require_relative '../lib/file_opener'

class CustomerRepository
  include FileOpener
  attr_reader :sales_engine,
              :all_customer_data

  # def inspect
  #   "#<#{self.class} #{@items.size} rows>"
  # end

  def initialize(data_files, sales_engine)
    @sales_engine = sales_engine
    all_customers = open_csv(data_files[:customers])
    @all_customer_data = all_customers.map{|row| Customer.new(row, self)}
  end

  def all
    @all_customer_data
  end

  def find_by_id(id)
    @all_customer_data.find{|customer| customer.id == id}
  end

  def find_all_by_first_name(name)
    @all_customer_data.find_all{|cust|  /#{name}/i =~ cust.first_name}
  end

  def find_all_by_last_name(name)
    @all_customer_data.find_all{|cust|  /#{name}/i =~ cust.last_name}
  end

  def merch(id)
    @sales_engine.customer_output(id)
  end
end
