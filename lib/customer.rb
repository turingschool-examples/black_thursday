require 'time'

class Customer

  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :customer_repo

  def initialize(customer_info, customer_repo)
    @id             = customer_info[:id].to_i
    @first_name     = customer_info[:first_name]
    @last_name      = customer_info[:last_name]
    @created_at     = Time.parse(customer_info[:created_at])
    @updated_at     = Time.parse(customer_info[:updated_at])
    @customer_repo  = customer_repo
  end

  def merchants
    customer_repo.customer_repo_to_se_merchants(id)
  end

end
