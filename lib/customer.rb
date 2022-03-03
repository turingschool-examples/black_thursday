require "pry"

class Customer
  attr_reader :customer_attributes

  def initialize(attributes)
    @customer_attributes = attributes
    @customer_attributes[:id] = customer_attributes[:id].to_i
    @customer_attributes[:first_name] = customer_attributes[:first_name].downcase
    @customer_attributes[:last_name] = customer_attributes[:last_name].downcase
    @customer_attributes[:created_at] = customer_attributes[:created_at]
    @customer_attributes[:updated_at] = customer_attributes[:updated_at]
  end
end
