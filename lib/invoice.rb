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
    invoice_repository.engine.invoice_items.find_all_by_invoice_id(id).map do |invoice_item|
      invoice_repository.engine.items.find_by_id(invoice_item.item_id)
    end
  end

  def invoice_items
    invoice_repository.engine.invoice_items.find_all_by_invoice_id(id)
  end

  def transactions
    invoice_repository.engine.transactions.find_all_by_invoice_id(id)
  end

  def customer
    invoice_repository.engine.customers.find_by_id(customer_id)
  end

  def is_paid_in_full?
    transactions.any? {|transaction| transaction.result == "success"} ? true : false
  end

  def total
    invoice_repository.engine.invoice_items.find_all_by_invoice_id(id).reduce(0) do |total, invoice_item|
      is_paid_in_full? ? total + invoice_item.unit_price * invoice_item.quantity : next
    end
  end

end