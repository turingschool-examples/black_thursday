require_relative "customer"
require_relative "sales_engine"
require 'csv'
require 'pry'

class CustomerRepository
  attr_reader :customers,
              :sales_engine

  def initialize(parent, filename)
    @customers           = []
    @sales_engine        = parent
    @load                = load_file(filename)
  end

  def load_file(filename)
    customers_csv = CSV.open filename,
                             headers: true,
                             header_converters: :symbol
    customers_csv.each do |customer|
      @customers << Customer.new(customer, self) end
  end

  def all
    customers
  end

  def find_by_id(id)
    customers.find { |customer| customer.id == id.to_i }
  end

  def find_all_by_first_name(first_name)
    customers.find_all { |customer| customer.first_name == first_name }
  end

  def find_all_by_last_name(last_name)
    customers.find_all { |customer| customer.last_name == last_name }
  end

  def inspect
      "#<#{self.class} #{@customers.size} rows>"
  end

  def find_invoices_by_customer_id(id)
    @sales_engine.find_invoices_by_customer_id(id)
  end

  def find_merchant_by_merchant_id(id)
    @sales_engine.find_merchant_by_merchant_id(id)
  end

end
