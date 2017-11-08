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
    if successful_transactions == true
      return true
    end
    false
  end

  def successful_transactions
    transactions.each do |transaction|
      return true if transaction.result == "success"
    end
  end

  # def find_valid_invoice_items
  #   successful_transactions.map do |transaction|
  #     transaction.invoice_items
  #   end.flatten
  # end

  def total
      total_invoice_items_price(invoice_items)
  end

  def total_invoice_items_price(invoice_items)
    invoice_items.reduce(0) do |sum, invoice_item|
      sum += (invoice_item.unit_price * invoice_item.quantity)
    end
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
