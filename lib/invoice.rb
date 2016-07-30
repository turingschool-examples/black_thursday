require_relative "../lib/invoice_repo"

class Invoice

  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at

  def initialize(row, parent = nil)
    @parent = parent
    @id = row[:id].to_i
    @customer_id = row[:customer_id].to_i
    @merchant_id = row[:merchant_id].to_i
    @status = row[:status].to_sym
    @created_at = Time.strptime(row[:created_at], "%Y-%m-%d")
    @updated_at = Time.strptime(row[:updated_at], "%Y-%m-%d")
  end

  def merchant
    @parent.find_merchant_by_id(self.merchant_id)
  end

  def items

  end

  def transactions

  end

  def customer

  end

  def is_paid_in_full?

  end

  def total
    invoice_items = @parent.find_all_invoice_items_by_invoice_id(self.id)
    invoice_items.reduce(0) do |total, invoice_item|
      total += invoice_item.unit_price
    end
  end

end
