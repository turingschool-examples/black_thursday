require 'time'

class Invoice
  attr_reader :invoice, :invoice_repo

  def initialize(invoice, invoice_repo)
    @invoice = invoice
    @invoice_repo = invoice_repo
  end

  def id
    invoice.fetch(:id).to_i
  end

  def customer_id
    invoice.fetch(:customer_id).to_i
  end

  def merchant_id
    invoice.fetch(:merchant_id).to_i
  end

  def status
    invoice.fetch(:status).to_sym
  end

  def created_at
    Time.parse(invoice.fetch(:created_at))
  end

  def updated_at
    Time.parse(invoice.fetch(:updated_at))
  end

  def merchant
    invoice_repo.invoice_merchant(self.merchant_id)
  end
end
