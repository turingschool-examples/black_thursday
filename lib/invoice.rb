require 'time'

class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status,
              :sales_engine

  def initialize(data, sales_engine)
    @id = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status = data[:status].to_sym
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @sales_engine = sales_engine
  end

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end

  def merchant
    sales_engine.merchants.find_by_id(merchant_id)
  end

  def items
    sales_engine.invoice_items.find_all_by_invoice_id(id)
  end

  def transactions
    sales_engine.transactions.find_all_by_invoice_id(id)
  end

  def customer
    sales_engine.customers.find_by_id(customer_id)
  end

  def is_paid_in_full?
    transactions.any? {|transaction| transaction.status == "success"}
  end

  def total
    if !is_paid_in_full?
      0
    else
      items = sales_engine.invoice_items.find_all_by_invoice_id(id)
      items.reduce(0) do |total, item|
        total + item.unit_price * item.quantity
      end
    end
  end


end
