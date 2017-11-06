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
    @parent
  end
end
