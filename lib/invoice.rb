require 'time'

class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at, :invoice_repo

  def initialize(invoice_hash, invoice_repo)
    @id           = invoice_hash[:id].to_i
    @customer_id  = invoice_hash[:customer_id]
    @merchant_id  = invoice_hash[:merchant_id]
    @status       = invoice_hash[:status]
    @created_at   = Time.now
    @updated_at   = Time.now
    @invoice_repo = invoice_repo
  end

end
