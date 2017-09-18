require 'csv'
require 'time'
require_relative 'sales_engine'

class Customer

  attr_reader :id, :first_name, :last_name, :created_at, :updated_at,:engine

  def initialize(customer_info, engine)
    @id = customer_info[:id].to_i
    @first_name = customer_info[:first_name]
    @last_name = customer_info[:last_name]
    @created_at = Time.parse(customer_info[:created_at])
    @updated_at = Time.parse(customer_info[:updated_at])
    @engine = engine
  end
end
