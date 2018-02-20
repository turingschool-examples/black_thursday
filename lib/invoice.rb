class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :created_time
  def initialize(hash)
    @id = hash[:id]
    @customer_id = hash[:customer_id]
    @merchant_id = hash[:merchant_id]
    @status = hash[:status]
    @created_at = hash[:created_at]
    @created_time = hash[:created_time]
  end
end
