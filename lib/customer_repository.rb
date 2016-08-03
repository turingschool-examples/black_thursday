require_relative 'customer'

class CustomerRepository
  attr_reader :customers, :parent

  def initialize(customer_contents, parent = nil)
    @customers = make_customers(customer_contents)
    @parent = parent
  end

  def make_customers(customer_contents)
    customer_contents.map { |row| Customer.new(row, self) }
  end

  def all
    @customers
  end

  def find_by_id(id)
    @customers.find { |customer| customer.id == id }
  end

  def find_all_by_first_name(first_name)
    @customers.find_all { |customer| customer.first_name.upcase.include?(first_name.upcase) }
  end

  def find_all_by_last_name(last_name)
    @customers.find_all { |customer| customer.last_name.upcase.include?(last_name.upcase) }
  end

  def find_all_merchants_by_id(customer_id)
    parent.find_all_merchants_by_customer_id(customer_id)
  end

  def find_fully_paid_invoices_by_customer_id(customer_id)
    parent.find_fully_paid_invoices_by_customer_id(customer_id)
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end
end
