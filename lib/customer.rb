require 'time'

class Customer

  attr_reader :id

  def initialize(customer_info, customer_repo)
    @id = customer_info[:id].to_i
  end

end
