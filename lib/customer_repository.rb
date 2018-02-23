require_relative 'customer'
require 'CSV'
require 'pry'

# customer repository class
class CustomerRepository
  def initialize(filepath, parent = nil)
    @customers = []
    load_customers(filepath)
    @parent = parent
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end

  def load_customers(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @customers << Customer.new(data, self)
    end
  end

  def all
    @customers
  end

  def find_by_id(id)
    @customers.find do |customer|
      customer.id == id
    end
  end

  def find_all_by_first_name(name)
    @customers.find_all do |customer|
      customer.first_name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_last_name(name)
    @customers.find_all do |customer|
      customer.last_name.downcase.include?(name.downcase)
    end
  end

  def pass_customer_id_to_se(id)
    @parent.pass_customer_id_to_invoices(id)
  end

  def pass_merchant_id_to_se(merchant_id)
    @parent.pass_merchant_id_to_merchant_repo(merchant_id)
  end
end
