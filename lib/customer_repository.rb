require_relative 'sales_engine'
require_relative 'customer'
require 'csv'
require 'pry'

class CustomerRepository
  attr_reader :customers, :sales_engine

  def initialize(value_at_customer, sales_engine)
    @sales_engine = sales_engine
    make_customers(value_at_customer)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def make_customers(customer_hashes)
    @customers = customer_hashes.map do |customer_hash|
      Customer.new(customer_hash, self)
    end
  end

  def find_merchants(customer_id)
    invoices = @sales_engine.invoices.find_all_by_customer_id(customer_id)
    merchant_ids = invoices.map { |invoice| invoice.merchant_id }
    merchants = merchant_ids.map do |id|
      @sales_engine.merchants.find_by_id(id)
    end
  end

  def find_by_id(id)
    @customers.find { |object| object.id == id }
  end

  def find_all_by_first_name(name_fragment)
    @customers.find_all { |object| object.first_name.downcase.include?(name_fragment.downcase)}
  end

  def find_all_by_last_name(name_fragment)
    @customers.find_all { |object| object.last_name.downcase.include?(name_fragment.downcase)}
  end

end
