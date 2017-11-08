require 'time'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :parent

  def initialize(attributes, parent)
    @parent = parent
    @id = attributes[:id].to_i
    @customer_id = attributes[:customer_id].to_i
    @merchant_id = attributes[:merchant_id].to_i
    @status = attributes[:status].to_sym
    @created_at = Time.parse(attributes[:created_at])
    @updated_at = Time.parse(attributes[:updated_at])
  end

  def merchant
    parent.find_merchant_by_id(merchant_id)
  end

  def items
    parent.find_items_by_invoice_id(id)
  end

  def transactions
    parent.find_transaction_by_invoice_id(id)
  end

  def customer
    parent.find_customer_by_id(customer_id)
  end

  def is_paid_in_full?
    return false if transactions.empty?
    transactions.any? do |transaction|
      transaction.result == 'success'
    end
  end

  def invoice_items
    parent.find_invoice_items_by_invoice_id(id)
  end

  def total
    return 0 if !is_paid_in_full?
    invoice_items.reduce(0) do |sum, item|
      sum += (item.unit_price * item.quantity)
    end
  end
end
