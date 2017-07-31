require 'time'

class Customer

  attr_reader :id,
              :first_name

  def initialize(customer_info, customer_repo)
    @id = customer_info[:id].to_i
    @first_name = customer_info[:first_name]
  end

end
