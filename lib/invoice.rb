class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  attr_writer :status,
              :updated_at

  def initialize(invoice)
    @id = invoice[:id].to_i
    @customer_id = invoice[:customer_id].to_i
    @merchant_id = invoice[:merchant_id].to_i
    @status = invoice[:status]
    @created_at = invoice[:created_at]
    @updated_at = invoice[:updated_at]
  end

end
