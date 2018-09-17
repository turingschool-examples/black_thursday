require 'pry'
class Invoice
  attr_reader   :id,
                :customer_id,
                :merchant_id,
                :status,
                :created_at,
                :updated_at

  def initialize(invoice_hash)
    @id           = invoice_hash[:id].to_i
    @customer_id  = invoice_hash[:customer_id]
    @merchant_id  = invoice_hash[:merchant_id]
    @status       = invoice_hash[:status]
    @created_at   = invoice_hash[:created_at]
    @updated_at   = invoice_hash[:updated_at]
  end
end
