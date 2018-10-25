require_relative 'business_data'

class Customer < BusinessData
  attr_reader :id, :created_at
  attr_accessor :first_name, :last_name, :updated_at
  def initialize(input_hash)
    @id = input_hash[:id]
    @first_name = input_hash[:first_name]
    @last_name = input_hash[:last_name]
    @created_at = input_hash[:created_at]
    @updated_at = input_hash[:updated_at]
  end
end
