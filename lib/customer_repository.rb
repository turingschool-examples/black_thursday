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

  



  def add_data(data)
    @customers << Customer.new(data.to_hash, @sales_engine)
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end


end
