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

  def items
    invoice_repo.invoices_items(self.id)
  end

  def transactions
    invoice_repo.invoice_transactions(self.id)
  end

  def customer
    invoice_repo.invoice_customer(self.customer_id)
  end

  def is_paid_in_full?
    result = false
    transactions.each do |transaction|
      if transaction.result == "success"
        result = true
      end
    end
    result
  end

  def total
    if self.is_paid_in_full?
      invoice_repo.total_amount(self.id)
    end
  end
end
