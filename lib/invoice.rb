require 'time'

class Invoice

attr_reader :id,
            :customer_id,
            :merchant_id,
            :status,
            :created_at,
            :updated_at,
            :repository

  def initialize (row, parent)
    @id           = row[:id].to_i
    @customer_id  = row[:customer_id].to_i
    @merchant_id  = row[:merchant_id].to_i
    @status       = row[:status].to_sym
    @created_at   = Time.parse(row[:created_at])
    @updated_at   = Time.parse(row[:updated_at])
    @repository   = parent
  end

  def is_paid_in_full?
    if transactions.count == 0
      true
    elsif transactions.count == successful_transactions.count
      true
    else false
    end
  end

  def successful_transactions
    transactions.find_all do |transaction|
      transaction.result == "success"
    end
  end

  def total
    if is_paid_in_full?
      total_invoice_items_price(invoice_items)
    end
  end

  def total_invoice_items_price(invoice_items)
    invoice_items.map do |invoice_item|
      (invoice_item.unit_price * invoice_item.quantity)
    end.sum
  end

  def invoice_items_for_successful_transactions
    repository.find_invoice_items_by_invoice_id
  end

  def format_date(date)
    date.strftime("%Y-%m-%d")
  end

  def merchant
    repository.find_merchant(self.merchant_id)
  end

  def items
    repository.find_items_by_invoice_id(self.id)
  end

  def transactions
    repository.find_transactions_by_invoice_id(self.id)
  end

  def customer
    repository.find_customer_by_customer_id(self.customer_id)
  end

  def invoice_items
    repository.find_invoice_items_by_invoice_id(self.id)
  end

  def unit_price_to_dollars(unit_price)
    (unit_price).round(2).to_f
  end

end
