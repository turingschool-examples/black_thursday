# frozen_string_literal: true

# This is a Customer class for Black Friday

class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(customer)
    @id = customer[:id].to_i
    @first_name = customer[:first_name]
    @last_name = customer[:last_name]
    @created_at = customer[:created_at]
    @updated_at = customer[:updated_at]
  end

  def update(attribute)
    @first_name = attribute.split(' ').first
    @last_name = attribute.split(' ').last
    @updated_at = Time.now
    self
  end
end
