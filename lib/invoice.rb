require 'time'

class Invoice

  attr_reader :id,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,
              :parent,
              :status,
              :customer_id

  def initialize(invoice_info = nil, repo = nil)
    return if invoice_info.to_h.empty?
    @parent      = repo
    @id          = invoice_info[:id].to_i
    @customer_id = invoice_info[:customer_id].to_i
    @status      = invoice_info[:status].to_sym if invoice_info[:status]
    @created_at  = Time.parse(invoice_info[:created_at].to_s)
    @updated_at  = Time.parse(invoice_info[:updated_at].to_s)
    @merchant_id = invoice_info[:merchant_id].to_i
  end

  def merchant
    parent.find_merchant_by_id(merchant_id)
  end

  def transactions
    parent.find_transactions_by_invoice_id(id)
  end

  def customer
    parent.find_customer_by_id(customer_id)
  end

  def items
    parent.find_items_by_invoice_id(id)
  end

  def invoice_items
    parent.find_invoice_items_for_invoice(id)
  end

  def total
    return "Failed transaction" unless self.is_paid_in_full?
    invoice_items.map do |invoice_item|
      invoice_item.unit_price * invoice_item.quantity
    end.reduce(:+).round(2)
  end

  def is_paid_in_full?
    transactions.any? { |transaction| transaction.result == "success" }
  end

end
