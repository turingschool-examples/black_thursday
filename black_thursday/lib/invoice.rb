require 'time'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :parent

  def initialize(attributes, parent = nil)
    @id           = attributes[:id].to_i
    @customer_id  = attributes[:customer_id].to_i
    @merchant_id  = attributes[:merchant_id].to_i
    @status       = attributes[:status].to_sym
    @created_at   = Time.parse(attributes[:created_at])
    @updated_at   = Time.parse(attributes[:updated_at])
    @parent       = parent
  end

  def merchant
    @parent.find_merchant_by_invoice(merchant_id)
  end

  def items
    @parent.find_item_by_invoice_id(id)
  end

  def transactions
    @parent.find_all_transactions_by_transaction_id(id)
  end

  def is_paid_in_full?
    !transactions.empty? && transactions.all? do |transaction|
      transaction.result == 'success'
    end
  end

  def invoice_items
    parent.find_invoice_item_by_invoice_id(id)
  end

  def customer
    parent.find_customer_by_invoice_id(customer_id)
  end

  def total
  invoice_items.reduce(0) do |unit, invoice_item|
    unit += is_paid_in_full? ? invoice_item.unit_price_to_dollars : 0
    end
  end
end
