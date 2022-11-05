class CustomerRepository 

  def initialize(customers)
    @customers = customers
  end 

  def all
    @customers
  end 

  def find_by_id(id)
    @customers.find {|customer| customer.id == id}
  end 

  def find_all_by_first_name(first_name)
    @customers.find_all {|customer| customer.first_name == first_name}
  end 
end 