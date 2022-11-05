class CustomerRepository 

  def initialize(customers)
    @customers = customers
  end 

  def all
    @customers
  end 

  def find_by_id(id)
    customer = @customers.find {|customer| customer.id == id}
  end 
end 