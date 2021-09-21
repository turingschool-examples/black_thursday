require 'time'
require_relative './sales_engine'

class Customer
  attr_reader :id,
              :created_at
  attr_accessor :first_name,
                :last_name,
                :updated_at

  def initialize(customers)
    @id = customers[0].to_i
    @first_name = customers[1]
    @last_name = customers[2]
    @created_at = Time.parse(customers[3])
    @updated_at = Time.parse(customers[4])
  end
end
