require 'time'

class Customer
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at,
  :customer_repo

  def initialize(customer, customer_repo)
     @id = customer[:id].to_i
     @first_name = customer[:first_name]
     @last_name = customer[:last_name]
     @created_at = Time.parse(customer[:created_at])
     @updated_at = Time.parse(customer[:updated_at])
     @customer_repo = customer_repo
  end

  def merchants
    customer_repo.merchant_customers(self.id)
  end

end
