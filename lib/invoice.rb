require 'csv'
require_relative '../lib/invoice_repo'
require 'pry'
require 'time'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(data, repo)
      @parent = repo
      @id = data[:id].to_i
      @customer_id = data[:customer_id].to_i
      @merchant_id = data[:merchant_id].to_i
      @status = data[:status].to_sym
      @created_at = data[:created_at]
      @updated_at = data[:updated_at]
  end

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end

  def merchant
    @parent.find_merchant_by_id(merchant_id)
  end

  def items
    find_invoice_items.map do |item| 
      @parent.find_items_for_invoice(item.item_id)
    end
  end

  def find_invoice_items
    @parent.find_invoice_items(id)
  end

  def transactions
    @parent.find_transactions_by_id(id)
  end
  
  def customer
    @parent.find_customer_from_invoice(customer_id)
  end

  def is_paid_in_full?
    results = transactions.map do |transaction|
      transaction.result.include?("success")
    end 
    if results.include?(true) 
      true
    else
      false
    end
  end

  def total
    prices = find_invoice_items.map do |invoice_item|
      invoice_item.unit_price * invoice_item.quantity
    end
    prices.reduce(:+)
  end
end
