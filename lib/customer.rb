require 'time'

class Customer

  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(customer_info, customer_repo)
    @id         = customer_info[:id].to_i
    @first_name = customer_info[:first_name]
    @last_name  = customer_info[:last_name]
    @created_at = Time.parse(customer_info[:created_at])
    @updated_at = Time.parse(customer_info[:updated_at])
  end

end
