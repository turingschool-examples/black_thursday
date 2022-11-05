class CustomerRepository 

  def initialize(customers)
    @customers = customers
  end 

  def all
    @customers
  end 
end 