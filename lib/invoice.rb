require 'csv'
require 'time'
require 'bigdecimal'
require 'pry'

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

end
