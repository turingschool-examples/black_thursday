class Customer

  attr_reader :first_name,
              :last_name,
              :created_at

  def initialize(customer_data)
    @first_name = customer_data[:first_name]
    @last_name  = customer_data[:last_name]
    @created_at = customer_data[:created_at]
  end

end
