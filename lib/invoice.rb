class Invoice
  attr_accessor :id,
                :invoice_id,
                :status,
                :created_at,
                :updated_at,
                :merchant_id,
                :customer_id

  def initialize(invoice_hash)
    @id = invoice_hash[:id]
    @invoice_id = invoice_hash[:invoice_id]
    @status = invoice_hash[:status]
    @created_at = invoice_hash[:created_at]
    @updated_at = invoice_hash[:updated_at]
    @merchant_id = invoice_hash[:merchant_id]
    @customer_id = invoice_hash[:customer_id]
  end
end
