require_relative '../modules/traversal'
# This is the invoice class
class Invoice
  include Traversal

  attr_reader :parent,
              :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(data, parent)
    @parent      = parent
    @id          = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status      = data[:status].to_sym
    @created_at  = Time.parse(data[:created_at])
    @updated_at  = Time.parse(data[:updated_at])
  end

  def merchant
    traverse('find_merchant', merchant_id)
  end

  def items
    traverse('find_items_by_invoice_id', id)
  end

  def transactions
    traverse('find_transactions_by_invoice_id', id)
  end

  def customer
    traverse('find_customer_by_customer_id', customer_id)
  end

  def is_paid_in_full?
    traverse('find_transaction_payment_status', id)
  end

  def total
    traverse('total_invoice_cost', id)
  end

  def invoice_items
    traverse('find_invoice_items', id)
  end
end
