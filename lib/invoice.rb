require_relative 'traversal'
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
    traverse('invoices merchant', merchant_id)
  end

  def items
    traverse('invoice items', id)
  end

  def transactions
    traverse('invoice transactions', id)
  end

  def customer
    traverse('invoice customer', customer_id)
  end

  def is_paid_in_full?
    traverse('transaction payment', id)
  end

  def total
    traverse('total invoice cost', id)
  end

  def invoice_items
    traverse('find invoice items', id)
  end
end
