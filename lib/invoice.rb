require 'time'

class Invoice
  attr_reader :invoice, :id, :customer_id, :merchant_id, :status, :created_at, :updated_at, :invoice_repo

  def initialize(invoice, invoice_repo)
    @id = invoice[:id].to_i
    @customer_id = invoice[:customer_id].to_i
    @merchant_id = invoice[:merchant_id].to_i
    @status = invoice[:status].to_sym
    @created_at = Time.parse(invoice[:created_at])
    @updated_at = Time.parse(invoice[:updated_at])
    @invoice_repo = invoice_repo
  end

  def merchant
    invoice_repo.invoice_merchants(self.merchant_id)
  end
end
