require_relative 'helper'

class InvoiceItem
  attr_reader   :invoice_id,
                :item_id,
                :created_at

  attr_accessor :id,
                :unit_price,
                :quantity,
                :updated_at

  def initialize(invoice_item_hash)
    @id           = invoice_item_hash[:id].to_i
    @item_id      = invoice_item_hash[:item_id].to_i
    @invoice_id   = invoice_item_hash[:invoice_id].to_i
    @unit_price   = BigDecimal.new(invoice_item_hash[:unit_price].to_i)/100
    @quantity     = invoice_item_hash[:quantity].to_i
    @created_at   = invoice_item_hash[:created_at]
    @updated_at   = invoice_item_hash[:updated_at]
  end
end
