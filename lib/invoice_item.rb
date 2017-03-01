require 'bigdecimal'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :unit_price,
              :iir

  def initialize (data_hash, iir)
    @id         = data_hash[:id].to_i
    @item_id    = data_hash[:item_id].to_i
    @invoice_id = data_hash[:invoice_id].to_i
    @quantity   = data_hash[:quantity].to_i
    @created_at = Time.parse(data_hash[:created_at])
    @updated_at = Time.parse(data_hash[:updated_at])
    @unit_price = BigDecimal.new(data_hash[:unit_price], 4)/100
    @iir = iir
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def find_items_by_ids
    iir.sales_engine.items.find_by_id(item_id)
  end
end