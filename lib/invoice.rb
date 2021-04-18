class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(transaction_details)
    @id = transaction_details[:id]
    @customer_id = transaction_details[:customer_id]
    @merchant_id = transaction_details[:merchant_id]
    @status = transaction_details[:status]
    @created_at = transaction_details[:created_at]
    @updated_at = transaction_details[:updated_at]
  end

  def update_id(id)
    @id = id
  end

  def update_status(status)
    @status = status unless status.nil?
  end

  def update_time
    @updated_at = Time.now
  end
end
