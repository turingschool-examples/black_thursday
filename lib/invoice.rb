require_relative 'business_data'

class Invoice < BusinessData
  attr_reader :id, :customer_id, :merchant_id, :created_at
  attr_accessor :status, :updated_at

  def initialize(input_hash)
    @id = input_hash[:id]
    @customer_id = input_hash[:customer_id]
    @merchant_id = input_hash[:merchant_id]
    @status = input_hash[:status]
    @created_at = input_hash[:created_at]
    @updated_at = input_hash[:updated_at]
  end
end
