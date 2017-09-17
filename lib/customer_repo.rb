require 'csv'
require_relative 'customer'
class CustomersRepo

  attr_reader :all_customers, :parent

  def initialize(file, se=nil)
    @all_customers = []
    open_file(file)
    @parent = se
  end

  def open_file(file)
    CSV.foreach file,  headers: true, header_converters: :symbol do |row|
      all_customers << Customer.new(row, self)
    end
  end
  def all
    @all_customers
  end
  def find_by_id(cust_id)
    all_customers.find {|customer| customer.id == cust_id }
  end

  def find_all_by_first_name(first_name)
    all_customers.find_all do |customer|
      customer.first_name.downcase.include?(first_name.downcase)
    end
  end

  def find_all_by_last_name(last_name)
    all_customers.find_all do |customer|
      customer.last_name.downcase.include?(last_name.downcase)
    end
  end

end
