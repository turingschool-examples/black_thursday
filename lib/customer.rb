require 'time'

class Customer
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at
  def initialize(attributes)
    @id = attributes[:id]
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
  end
end
