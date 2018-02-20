class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :created_time
  def initialize(hash, parent)
    @id = hash[:id].to_i
    @customer_id = hash[:customer_id].to_i
    @merchant_id = hash[:merchant_id].to_i
    @status = hash[:status]
    @created_at = hash[:created_at]
    @created_time = hash[:created_time]
    @parent = parent
  end
end
