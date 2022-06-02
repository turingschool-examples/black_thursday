class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at
  attr_writer :status

  def initialize(invoice)
    @id = invoice[:id]
    @customer_id = invoice[:customer_id]
    @merchant_id = invoice[:merchant_id]
    @status = invoice[:status]
    @created_at = invoice[:created_at]
    @updated_at = invoice[:updated_at]
  end

end
