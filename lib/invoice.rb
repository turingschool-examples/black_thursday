require './test/helper'

class Invoice
  attr_reader   :customer_id,
                :merchant_id,
                :created_at

  attr_accessor :id,
                :status,
                :updated_at

  def initialize(invoice_hash)
    @id           = invoice_hash[:id].to_i
    @customer_id  = invoice_hash[:customer_id].to_i
    @merchant_id  = invoice_hash[:merchant_id].to_i
    @status       = invoice_hash[:status]
    @created_at   = invoice_hash[:created_at]
    @updated_at   = invoice_hash[:updated_at]
  end
end
12345
