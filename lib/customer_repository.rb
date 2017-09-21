require_relative 'csv_parser'
require_relative 'customer'

class CustomerRepository
  include CsvParser
  attr_reader :sales_engine
  attr_accessor :customers

  def initialize(file_name, sales_engine)
    @customers = []
    item_contents = parse_data(file_name)
    item_contents.each do |row|
      @customers << Customer.new(row, self)
    end
    @sales_engine = sales_engine
  end

  def all
    @customers
  end

  def find_by_id(id)
    @customers.find {|customer| customer.id == id}
  end

  def find_all_by_first_name(first_name)
    @customers.select do |customer|
      customer.first_name.downcase.include?(first_name.downcase)
    end
  end

  def find_all_by_last_name(last_name)
    @customers.select do |customer|
      customer.last_name.downcase.include?(last_name.downcase)
    end
  end

  def find_invoices_by_customer_id(customer_id)
    @sales_engine.invoices.find_all_by_customer_id(customer_id)
  end

  def find_merchants(merchant_id)
    @sales_engine.merchants.find_by_id(merchant_id)
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end

end
