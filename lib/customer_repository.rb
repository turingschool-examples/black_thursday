class CustomerRepository
  attr_reader :customers

  def initialize(customers)
    @customers = customers
  end

  def all
    @customers
  end
end
