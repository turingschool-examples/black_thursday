require 'time'

class Customer
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at, :customer_repo

  def initialize(customer_hash, customer_repo)
    @id         = customer_hash[:id]
    @first_name = customer_hash[:first_name]
    @last_name  = customer_hash[:last_name]
    @created_at = Time.parse(customer_hash[:created_at])
    @updated_at = Time.parse(customer_hash[:updated_at])
    @customer_repo = customer_repo
  end

end
