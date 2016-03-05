require 'pry'

class Customer
  attr_reader :repository, :id, :first_name, :last_name, :created_at, :updated_at
  def initialize(customer_hash, repository)
    @repository = repository
    @id = customer_hash[:id].to_i
    @first_name = customer_hash[:first_name]
    @last_name = customer_hash[:last_name]
    @created_at = Time.parse(customer_hash[:created_at])
    @updated_at = Time.parse(customer_hash[:updated_at])
  end

  def merchants
    @repository.find_merchants(@id)
  end

end
