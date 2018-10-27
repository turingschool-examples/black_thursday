require 'time'
class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at
  def initialize(invoice_info)
    @id          = invoice_info[:id]
    @customer_id = invoice_info[:customer_id]
    @merchant_id = invoice_info[:merchant_id]
    @status      = invoice_info[:status]
    @created_at  = invoice_info[:created_at]
    @updated_at  = invoice_info[:updated_at]
  end
end
