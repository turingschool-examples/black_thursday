require 'csv'
require_relative '../lib/customer'

class CustomerRepository
  def initialize(parent)
    @customers = []
    @invoices = parent
  end

  def from_csv(file_path)
    customer_data = CSV.open file_path, headers: true,
      header_converters: :symbol, converters: :numeric
    customer_data.each do |row|
      @customers << Customer.new(row.to_hash, self)
    end
  end

  def all
    return @customers
  end

  def find_by_id(id)
    @customers.find do |customer|
      customer.id == id
    end
  end

  def find_all_by_first_name(name_fragment)
    @customers.find_all do |customer|
      customer.first_name.downcase.include?(name_fragment.downcase)
    end
  end

  def find_all_by_last_name(name_fragment)
    @customers.find_all do |customer|
      customer.last_name.downcase.include?(name_fragment.downcase)
    end
  end

  def find_invoices_by_customer_id(customer_id)
    @invoices.find_invoices_by_customer_id(customer_id)
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end
end
