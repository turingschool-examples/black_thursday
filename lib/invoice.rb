require 'csv'
require 'time'
require 'bigdecimal'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :parent

  def initialize(invoice, repo = nil)
    @id = invoice[:id].to_i
    @customer_id = invoice[:customer_id].to_i
    @merchant_id = invoice[:merchant_id].to_i
    @status = invoice[:status].intern
    @created_at = Time.parse(invoice[:created_at].to_s)
    @updated_at =Time.parse(invoice[:updated_at].to_s)
    @parent = repo
  end

  def merchant
    parent.invoice_merchant(self.merchant_id)
  end

  def items
    parent.invoice_items_list(self.id)
  end

  def transactions
    parent.invoice_transactions(self.id)
  end

  def customer
    parent.invoice_customer(customer_id)
  end

  def invoice_items
    parent.invoice_items_for_invoice(id)
  end

  def total
    parent.total(id)
  end

  def is_paid_in_full?
    return false if transactions.empty?
    transactions.any? {|transaction| transaction.result == "success"}
  end

  def failed_transactions
    transactions.all? do |transaction|
      transaction.result == "failed"
    end
  end

end
