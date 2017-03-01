require 'time'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :parent

  def initialize(row, parent)
    @id = row[:id].to_i
    @customer_id = row[:customer_id].to_i
    @merchant_id = row[:merchant_id].to_i
    @status = row[:status].to_sym
    @created_at = Time.parse(row[:created_at])
    @updated_at = Time.parse(row[:updated_at])
    @parent = parent
  end

  def merchant
    parent.engine.merchants.find_by_id(merchant_id)
  end

  def items ***
    parent.engine.invoice_items.find_all_by_item_id(item_id)
  end

  def transactions
    parent.engine.transactions.find_all_by_invoice_id(id)
  end

  def customer
    parent.engine.customers.find_by_id(customer_id)
  end
end
