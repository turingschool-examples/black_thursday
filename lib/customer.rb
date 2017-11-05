require 'csv'
require 'time'

class Customer

  attr_reader :id, :first_name, :last_name,
              :created_at, :updated_at, :repository

  def initialize(data, repository)
    @id = data[:id].to_i
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @repository = repository
  end

  def merchants
    repository.find_merchants_by_customer_id(@id)
  end


end
