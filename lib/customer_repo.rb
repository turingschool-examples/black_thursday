require './lib/customer'

class CustomerRepo
  def initialize(sales_engine = nil)
    @customers = []
  end

  def add_customer(customer_details)
    @customers << Customer.new(customer_details, self)
  end

  def all
    @customers
  end

  def find_by_id(id)
    @customers.find do |customer|
      customer.id == id
    end
  end

  def find_all_by_first_name(first_name)
    @customers.find_all do |customer|
      customer.first_name == first_name
    end
  end

  def find_all_by_last_name(last_name)
    @customers.find_all do |customer|
      customer.last_name == last_name
    end
  end
end
