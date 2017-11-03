class CustomerRepository
  attr_reader :customers,
              :parent

  def initialize(customers, parent)
    @parent = parent
    @customers = customers.map {|customer| Customer.new(customer, self)}
  end

end
