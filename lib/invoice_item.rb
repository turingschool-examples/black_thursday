require 'pry'
require 'bigdecimal'
require 'time'

class InvoiceItem

  attr_reader :id, :item_id, :invoice_id, :merchant_id,
              :unit_price, :invoice_item_repo,
              :total, :created_at

  attr_accessor :status,
                :customer_id,
                :updated_at,
                :quantity,
                :updated_at

  def initialize(invoice_item_data, parent)
    @id                = invoice_item_data[:id]
    @item_id           = invoice_item_data[:item_id]
    @invoice_id        = invoice_item_data[:invoice_id]
    @quantity          = invoice_item_data[:quantity]
    @unit_price        = BigDecimal(invoice_item_data[:unit_price]) / 100
    @created_at        = invoice_item_data[:created_at]
    @merchant_id       = invoice_item_data[:merchant_id]
    @updated_at        = invoice_item_data[:updated_at]
    @invoice_item_repo = invoice_item_repo
    @total             = 0
    @status            = invoice_item_data[:status]
    @customer_id       = invoice_item_data[:customer_id]
  end
end