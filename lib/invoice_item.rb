require 'pry'
require 'bigdecimal'

class InvoiceItem

  attr_reader :id, :item_id, :invoice_id, :quantity, :merchant_id,
              :unit_price, :created_at, :invoice_item_repo,
              :total

  attr_accessor :status,
                :customer_id,
                :updated_at

  def initialize(invoice_item_data, parent)
    @id                = invoice_item_data[:id]
    @item_id           = invoice_item_data[:item_id]
    @invoice_id        = invoice_item_data[:invoice_id]
    @quantity          = invoice_item_data[:quantity]
    @unit_price        = invoice_item_data[:unit_price]
    @created_at        = Time.now
    @merchant_id       = invoice_item_data[:merchant_id]
    @updated_at        = Time.now
    @invoice_item_repo = invoice_item_repo
    @total             = 0
    @status            = invoice_item_data[:status]
    @customer_id       = invoice_item_data[:customer_id]
  end
end