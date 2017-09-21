require 'time'
require 'bigdecimal'

class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :day_of_week

  def initialize(invoice_data, invoice_repository)
      @id = invoice_data[:id].to_i
      @customer_id = invoice_data[:customer_id].to_i
      @merchant_id = invoice_data[:merchant_id].to_i
      @status = invoice_data[:status].to_sym
      @created_at = Time.parse(invoice_data[:created_at])
      @updated_at = Time.parse(invoice_data[:updated_at])
      @invoice_repository = invoice_repository
      @day_of_week = @created_at.strftime('%A')
  end

  def merchant
      @invoice_repository.sales_engine.merchants.find_by_id(@merchant_id)
  end

  def items
    invoice_items.map do |invoice_item|
      @invoice_repository.find_item_by_item_id(invoice_item.item_id)
    end
  end

  def transactions
    @invoice_repository.find_all_transactions_by_invoice_id(@id)
  end

  def customer
    @invoice_repository.find_customer_by_id(@customer_id)
  end

  def invoice_items
    @invoice_repository.find_all_invoice_items_by_invoice_id(@id)
  end

  def is_paid_in_full?
    return false if transactions.count == 0
    transactions.any? do |transaction|
      transaction.result == 'success'
    end
  end

  def partially_paid_transactions
    transactions.select do |transaction|
      transaction.result == 'success'
    end
  end

  def total
    return 0 unless is_paid_in_full?
    invoice_items.reduce(BigDecimal.new(0, 4)) do |invoice_total ,invoice_item|
      (invoice_item.unit_price * invoice_item.quantity) + invoice_total
    end
  end

end
