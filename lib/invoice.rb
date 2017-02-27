require 'date'

class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at, :invoice_repository

  def initialize(info = {}, invoice_repository = "")
    @id = info[:id].to_i
    @customer_id = info[:customer_id].to_i
    @merchant_id = info[:merchant_id].to_i
    @status = info[:status].to_sym
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
    @invoice_repository = invoice_repository
  end

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end

  def merchant
    invoice_repository.engine.merchants.find_by_id(merchant_id)
  end

  def items
    invoice_repository.engine.invoice_items.find_all_by_invoice_id(id)
  end

  def transactions
    invoice_repository.engine.transactions.find_all_by_invoice_id(id)
  end

  def customer
    invoice_repository.engine.customers.find_by_id(customer_id)
  end

  def is_paid_in_full?
    result = transactions.map {|transaction| transaction.result == "success"}
    if result.include?(false)
      false
    else
      true
    end
  end

  def total
    sum = items.reduce(0) do |total, item|
      total + item.unit_price_to_dollars * item.quantity
    end
    sum
  end

end