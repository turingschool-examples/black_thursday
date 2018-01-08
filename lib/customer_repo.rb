require_relative "customer"
require_relative "sales_engine"
require "memoist"
require "csv"

class CustomerRepo
  extend Memoist

  attr_reader :customers,
              :sales_engine

  def initialize(sales_engine, filename)
    @customers    = []
    @sales_engine = sales_engine
    load_customers(filename)
  end

  def load_customers(filename)
    customers_csv = CSV.open filename,
                             headers: true,
                             header_converters: :symbol,
                             converters: :numeric
    customers_csv.each do |row| @customers << Customer.new(row, self)
    end
  end

    def all
      customers
    end
    memoize :all

    def find_by_id(id)
      customers.find { |customer| customer.id == id }
    end

    def find_all_by_first_name(first_name)
      customers.find_all do |customer|
        customer.first_name.downcase.include?(first_name.downcase)
      end
    end

    def find_all_by_last_name(last_name)
      customers.find_all do |customer|
        customer.last_name.downcase.include?(last_name.downcase)
      end
    end

    def find_invoices_by_customer_id(id)
      sales_engine.find_invoices_by_customer_id(id)
    end

    # def find_merchant_by_merchant_id(id)
    #   sales_engine.find_all_merchants_by_id(id)
    # end
  end
