require 'time'
class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at
  def initialize(data, sales_engine)
    @sales_engine = sales_engine
    @id           = data[:id].to_i
    @customer_id  = data[:customer_id].to_i
    @merchant_id  = data[:merchant_id].to_i
    @status       = data[:status].to_sym          if data[:status]
    @created_at   = Time.parse(data[:created_at]) if data[:created_at]
    @updated_at   = Time.parse(data[:updated_at]) if data[:updated_at]
  end

  def merchant
    @sales_engine.merchants.find_by_id(self.merchant_id)
  end

  def invoice_items
    @sales_engine.invoice_items.find_all_by_invoice_id(self.id)
  end

  def items
    invoice_items.map do |ii|
      @sales_engine.items.find_by_id(ii.item_id)
    end
  end

  def transactions
    @sales_engine.transactions.find_all_by_invoice_id(self.id)
  end

  def customer
    @sales_engine.customers.find_by_id(self.customer_id)
  end

  def is_paid_in_full?
    transactions.any? do |transaction|
      transaction.result == "success"
    end
  end

  def total
    total = 0
    if is_paid_in_full?
      invoice_items.each do |ii|
        total += (ii.unit_price * ii.quantity)
      end
    end
    total
  end

end
