require 'pry'

class Invoice
  attr_reader :id, :customer_id, :merchant_id, :created_at, :updated_at,
              :invoice_repo

  def initialize(column, parent = nil)
    @id = column[:id].to_i
    @customer_id = column[:customer_id].to_i
    @merchant_id = column[:merchant_id].to_i
    @status = column[:status]
    @created_at = Time.parse(column[:created_at])
    @updated_at = Time.parse(column[:updated_at])
    @invoice_repo = parent
  end

  def status
    @status.to_sym
  end

  def merchant
    merchant_id = self.merchant_id
    @invoice_repo.find_merchant_by_invoice_merch_id(merchant_id)
  end

  def day_of_the_week
    created_at.strftime("%w")
  end

  def items
    invoice_item_array = invoice_items
    invoice_item_array.map do |invoice_item|
      invoice_repo.find_items_by_invoice_id(invoice_item.item_id)
    end
  end

  def invoice_items
    invoice = self.id
    invoice_repo.find_invoice_items_by_invoice_id(invoice)
    
  end

  def customer
    id = self.customer_id
    invoice_repo.find_customer_by_invoice_customer_id(id)
  end

  def transactions
    invoice_id = self.id
    invoice_repo.find_transactions_by_invoice_id(invoice_id)
  end

  def is_paid_in_full?
    transaction_array = transactions
    transaction_array.any? do |transaction|
      transaction.result == "success"
    end
  end

  def total
    if is_paid_in_full?
      items_array = items
      total = 0
      items_array.each do |item|
        price = item.unit_price
        total += price
      end
    end
    result = sprintf('%.02f', total).to_f
    result
    binding.pry
  end

end
