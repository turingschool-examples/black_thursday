class Customer

  attr_reader :first_name

  def initialize(customer_data)
    @first_name = customer_data[:first_name]
  end

end
