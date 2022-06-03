require 'csv'
class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(data_hash)
    @id = data_hash[:id]
    @customer_id = data_hash[:customer_id]
    @merchant_id = data_hash[:merchant_id]
    @status = data_hash[:status]
    @created_at = data_hash[:created_at]
    @updated_at = data_hash[:updated_at]
  end
end
