require 'bigdecimal'

class InvoiceItem

  attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at, :unit_price_to_dollars

  def initialize(invoice_item_hash)
    @id                    = invoice_hash[:id].to_i
    @item_id               = invoice_hash[:item_id]
    @invoice_id            = invoice_hash[:invoice_id]
    @quantity              = invoice_hash[:quantity]
    @unit_price            = BigDecimal.new(invoice_hash[:unit_price])
    @created_at            = invoice_hash[:created_at]
    @updated_at            = invoice_hash[:updated_at]
    @unit_price_to_dollars = unit_price.to_f
  end


end
