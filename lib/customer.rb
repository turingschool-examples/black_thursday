require_relative 'customer_repository'
require 'time'

class Customer

  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :customer_repository

  def initialize(customer_repository, csv_info)
    @id = csv_info[:id].to_i
    @first_name = csv_info[:first_name].to_s
    @last_name = csv_info[:last_name].to_s
    @created_at = Time.parse(csv_info[:created_at])
    @updated_at = Time.parse(csv_info[:updated_at])
    @customer_repository = customer_repository
  end

end
