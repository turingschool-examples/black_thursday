require 'time'

class Customer
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at

  def initialize(customer_hash)
    @id         = customer_hash[:id]
    @first_name = customer_hash[:first_name]
    @last_name  = customer_hash[:last_name]
    @created_at = Time.now
    @updated_at = Time.now
  end

end
