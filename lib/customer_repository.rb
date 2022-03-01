class CustomerRepository
  attr_reader :customers

  def initialize(customers)
    @customers = customers
  end

  def all
    @customers
  end

  def find_by_id(id)
    @customers.find {|customer| customer.id == id }
  end
end
