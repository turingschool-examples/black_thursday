require 'pry'
require 'time'

class Customer
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at

  def initialize(cust_info)
    @id         = cust_info[:id].to_i
    @first_name = cust_info[:first_name]
    @last_name  = cust_info[:last_name]
    @created_at = Time.parse(cust_info[:created_at])
    @updated_at = Time.parse(cust_info[:updated_at])
  end
end
