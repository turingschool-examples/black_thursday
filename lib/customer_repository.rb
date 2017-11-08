require_relative './customer'

class CustomerRepository
  attr_reader :customers,
              :parent

  def initialize(customers, parent)
    @parent = parent
    @customers = customers.map {|customer| Customer.new(customer, self)}
  end

  def all
    customers
  end

  def find_by_id(id)
    all.find do |customer|
      customer.id == id.to_i
    end
  end

  def find_all_by_first_name(name)
    all.find_all do |customer|
      customer.first_name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_last_name(name)
    all.find_all do |customer|
      customer.last_name.downcase.include?(name.downcase)
    end
  end

  def find_merchant_by_customer_id(customer_id)
    parent.find_merchant_by_customer_id(customer_id)
  end

  def find_all_invoices_by_customer_id(customer_id)
    parent.find_all_invoices_by_customer_id(customer_id)
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end
end
