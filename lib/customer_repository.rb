require_relative 'customer'

class CustomerRepository

  def initialize(customer_data, parent = nil)
    @customer_data = customer_data
    @parent = parent
  end

end
