require_relative '../lib/customer'

class CustomerRepo
  def initialize(sales_engine = nil)
    @customers = []
    @sales_engine = sales_engine
  end

  def add_customer(customer_details)
    # binding.pry
    @customers << Customer.new(customer_details, self)
  end

  def all
    @customers
  end

  def find_by_id(id)
    # binding.pry
    @customers.find do |customer|
      customer.id == id
    end
  end

  def find_all_by_first_name(first_name)
    @customers.find_all do |customer|
      customer.first_name.downcase.include?(first_name.downcase)
    end
  end

  def find_all_by_last_name(last_name)
    @customers.find_all do |customer|
      customer.last_name.downcase.include?(last_name.downcase)
    end
  end

  def find_invoices_by_customer_id(id)
    @sales_engine.find_invoices_by_customer_id(id)
  end

  def find_merchant_by_merchant_id(merchant_id)
    @sales_engine.find_merchant_by_merchant_id(merchant_id)
  end
end
