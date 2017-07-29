require 'time'

class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at, :invoice_repo

  def initialize(invoice_hash, invoice_repo)
    @id           = invoice_hash[:id]
    @customer_id  = invoice_hash[:customer_id]
    @merchant_id  = invoice_hash[:merchant_id]
    @status       = invoice_hash[:status]
    @created_at   = Time.parse(invoice_hash[:created_at])
    @updated_at   = Time.parse(invoice_hash[:updated_at])
    @invoice_repo = invoice_repo
  end

end
