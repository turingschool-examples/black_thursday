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
    if status == :shipped
      true
    else
      false
    end
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

  def total
    if is_paid_in_full?
      unit_price_to_dollars(invoice_items.unit_price)
    else
      puts "Sorry, that invoice hasn't been paid in full."
    end
  end

  def unit_price_to_dollars(unit_price)
    (unit_price).round(2).to_f
  end

end
