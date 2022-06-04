require 'csv'
class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(data_hash)
    @id = data_hash[:id]
    @first_name = data_hash[:first_name]
    @last_name = data_hash[:last_name]
    @created_at = data_hash[:created_at]
    @updated_at = data_hash[:updated_at]
  end





end
