# frozen_string_literal: true

# This is a Customer class for Black Thursday

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
    @created_at = Time.parse(customer[:created_at])
    @updated_at = Time.parse(customer[:updated_at])
  end

  def update(attributes)
    attributes.each do |key, value|
      @first_name = value if key == :first_name
      @last_name = value if key == :last_name
    end
    @updated_at = Time.now
    self
  end
end
