class Customer

  attr_reader :first_name,
              :last_name

  def initialize(customer_data)
    @first_name = customer_data[:first_name]
    @last_name = customer_data[:last_name]
  end

end
