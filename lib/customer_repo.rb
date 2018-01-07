require_relative "customer"
require_relative "sales_engine"
require "csv"

class CustomerRepo
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
  end
