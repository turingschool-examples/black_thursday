require 'bigdecimal'

class InvoiceItem
  attr_reader  :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at, :unit_price, :iir

  def initialize (information, iir)
    @id         = information[:id].to_i
    @item_id    = information[:item_id].to_i
    @invoice_id = information[:invoice_id].to_i
    @quantity   = information[:quantity].to_i
    @created_at = Time.parse(information[:created_at])
    @updated_at = Time.parse(information[:updated_at])
    @unit_price = BigDecimal.new(information[:unit_price], 4)/100
    @iir = iir
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def find_items_by_ids
    iir.sales_engine.items.find_by_id(item_id)
  end
end