require 'csv'
require 'time'
require 'bigdecimal'
require_relative 'sanitize'
require_relative 'customer_repository'

class Customer 
  attr_reader :id, 
              :first_name,
              :last_name,
              :created_at,
              :updated_at
  def initialize(info)
    @id = info[:id]
    @first_name = info[:first_name]
    @last_name = info[:last_name]
    @created_at = info [:created_at]
    @updated_at = [:updated_at]
  end
end
