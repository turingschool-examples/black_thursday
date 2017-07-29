require_relative '../lib/customer'

class CustomerRepository
  attr_reader :customers

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @customers    = []
  end

  def all
    @customers
  end

  def find_by_id(id)
    @customers.find do |customer|
      customer.id == id
    end
  end

  def find_all_by_first_name(f_name)
    @customers.find_all do |customer|
      customer.first_name == f_name
    end
  end

  def find_all_by_last_name(l_name)
    @customers.find_all do |customer|
      customer.last_name == l_name
    end
  end





  def add_data(data)
    @customers << Customer.new(data.to_hash, @sales_engine)
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end


end
