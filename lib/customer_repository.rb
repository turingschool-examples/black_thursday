require_relative "customer"
require "csv"

class CustomerRepository

  def initialize(customers_file, sales_engine)
    @customers = []
    items_from_csv(customers_file)
    @sales_engine = sales_engine
  end

  def items_from_csv(customers_file)
    CSV.foreach(customers_file, headers: true, header_converters: :symbol) do |row|
      @customers << Customer.new(row, self)
    end
  end

  def all
    @customers
  end

  def find_by_id(id)
    @customers.find {|customer| customer.id == id}
  end

  def find_all_by_first_name(fragment)
    @customers.find_all do |customer|
      customer.first_name.downcase.include?(fragment.downcase)
    end
  end

  def find_all_by_last_name(fragment)
    @customers.find_all do |customer|
      customer.last_name.downcase.include?(fragment.downcase)
    end
  end

  def merchant_customers(customer_id)
    sales_engine.find_customer_merchant(customer_id)
  end
  
  def inspect
    "#{self.class} #{customers.size} rows"
  end
end
