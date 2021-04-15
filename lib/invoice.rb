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
end
