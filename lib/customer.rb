require 'helper'

class Customer
  attr_reader :id,
              :created_at

  attr_accessor :updated_at,
                :first_name,
                :last_name

  def initialize(input)
    @id = input[:id].to_i
    @first_name = input[:first_name]
    @last_name = input[:last_name]
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
  end
end
