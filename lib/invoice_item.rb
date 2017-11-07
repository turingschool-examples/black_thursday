require 'time'
require 'bigdecimal'

class InvoiceItem
  attr_reader :invoice_items, :id, :item_id, :invoice_id, :quantity,
  :unit_price, :created_at, :updated_at, :invoice_item_repo

  def initialize(invoice_items, invoice_item_repo)
    @id = invoice_items[:id].to_i
    @item_id = invoice_items[:item_id].to_i
    @invoice_id = invoice_items[:invoice_id].to_i
    @quantity = invoice_items[:quantity].to_i
    @unit_price = BigDecimal.new(invoice_items[:unit_price].to_i)
    @created_at = Time.parse(invoice_items[:created_at])
    @updated_at =Time.parse(invoice_items[:updated_at])
    @invoice_item_repo = invoice_item_repo
  end

  def unit_price
    @unit_price/100.0
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def total
    unit_price * quantity.to_f
  end
end
