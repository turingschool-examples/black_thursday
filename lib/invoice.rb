require 'pry'
require 'time'

class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at
  attr_accessor :merchant, :items, :transactions, :customer, :item_price_quantity

  def initialize(invoice_info)
    @id          = invoice_info[:id].to_i
    @customer_id = invoice_info[:customer_id].to_i
    @merchant_id = invoice_info[:merchant_id].to_i
    @status      = invoice_info[:status].to_s.to_sym
    @created_at  = Time.parse(invoice_info[:created_at])
    @updated_at  = Time.parse(invoice_info[:updated_at])
  end

  def is_paid_in_full?
    transactions.map(&:result).include?("success")
  end

  def total
    items.reduce(0.0) do |sum, item|
      sum + item.unit_price
    end
  end

end
