class Customer

  attr_reader :name

  def initialize(customer_data)
    @name = customer_data[:first_name]
  end

end
