# frozen_string_literal: true

require 'time'
# This class holds the data for each invoice.
class Invoice
  attr_reader :invoice_specs,
              :parent
  def initialize(invoices_data, parent)
    @invoice_specs = {
      id:           invoices_data[:id].to_i,
      customer_id:  invoices_data[:customer_id].to_i,
      merchant_id:  invoices_data[:merchant_id].to_i,
      status:       invoices_data[:status],
      created_at:   invoices_data[:created_at],
      updated_at:   invoices_data[:updated_at]
    }
    @parent = parent
  end

  def id
    @invoice_specs[:id]
  end

  def customer_id
    @invoice_specs[:customer_id]
  end

  def merchant_id
    @invoice_specs[:merchant_id]
  end

  def status
    @invoice_specs[:status].to_sym
  end

  def created_at
    Time.parse(@invoice_specs[:created_at].to_s)
  end

  def updated_at
    Time.parse(@invoice_specs[:updated_at].to_s)
  end

  def merchant
    @parent.find_merchant_by_merchant_id(merchant_id)
  end

  def is_paid_in_full?
    transactions.any? { |transaction| transaction.result == 'success' }
  end

  def transactions
    @parent.find_transaction_by_invoice_id(id)
  end

  def customer
    @parent.find_customer_by_customer_id(@invoice_specs[:customer_id])
  end

  def items
    @parent.find_all_items_by_invoice_id(id)
  end

  def total
    all_items = @parent.find_all_invoice_items_by_invoice_id(id)
    all_items.map do |invoice_item|
      invoice_item.quantity * invoice_item.unit_price
    end.inject(:+).round(2)
  end
end
