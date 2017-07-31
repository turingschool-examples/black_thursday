require 'time'

class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status,
              :created_at, :updated_at, :invoice_repo

  def initialize(invoice_hash, invoice_repo)
    @id           = invoice_hash[:id].to_i
    @customer_id  = invoice_hash[:customer_id].to_i
    @merchant_id  = invoice_hash[:merchant_id].to_i
    @status       = invoice_hash[:status].to_sym
    @created_at   = Time.parse(invoice_hash[:created_at])
    @updated_at   = Time.parse(invoice_hash[:updated_at])
    @invoice_repo = invoice_repo
  end

  def merchant
    @invoice_repo.find_merchant_vendor(merchant_id)
  end

  def items
    @invoice_repo.find_items_by_invoice_id(id)
  end

  def transactions
    @invoice_repo.find_transactions_by_invoice_id(id)
  end

  def customer
    @invoice_repo.find_customers_by_invoice(customer_id)
  end

  def is_paid_in_full?
    return false if transactions.empty?
    transactions.any? { |transaction| transaction.result == "success" }
  end

  # def total
  #   @invoice_repo.
  # end

end
