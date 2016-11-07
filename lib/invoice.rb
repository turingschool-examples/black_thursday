require_relative './time_formatter'
require 'bigdecimal'

class Invoice
  include TimeFormatter
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :parent

  def initialize(invoice_data, parent = nil)
    @id          = invoice_data[:id].to_i
    @customer_id = invoice_data[:customer_id].to_i
    @merchant_id = invoice_data[:merchant_id].to_i
    @status      = invoice_data[:status].to_sym
    @created_at  = format_time(invoice_data[:created_at].to_s)
    @updated_at  = format_time(invoice_data[:updated_at].to_s)
    @parent      = parent
  end

  def merchant
    @parent.find_merchant_by_merchant_id(merchant_id)
  end

  def items
    invoice_items.map do |invoice_item|
      @parent.find_item_by_item_id(invoice_item.item_id)
    end
  end

  def invoice_items
    @parent.find_invoice_items_by_invoice_id(id)
  end

  def transactions
    @parent.find_transactions_by_invoice_id(id)
  end

  def customer
    @parent.find_customer_by_customer_id(customer_id)
  end

  def is_paid_in_full?
    transactions.any? { |transaction| transaction.result.eql?("success") }
  end

  def total
    invoice_items.each.reduce(0) do |result, invoice_item|
      result += (invoice_item.unit_price) * invoice_item.quantity
      result
    end
  end
end
