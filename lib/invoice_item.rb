require 'time'
require 'bigdecimal'

class InvoiceItem
  attr_accessor :id,
                :item_id,
                :invoice_id,
                :created_at,
                :updated_at,
                :unit_price,
                :quantity

  def initialize(item_hash)
    @id = item_hash[:id]
    @item_id = item_hash[:item_id]
    @invoice_id = item_hash[:invoice_id]
    @unit_price = item_hash[:unit_price]
    @created_at = (item_hash[:created_at])
    @updated_at = (item_hash[:updated_at])
    @quantity = item_hash[:quantity]
  end

  def unit_price_to_dollars
    @unit_price.to_f.round(2)
  end
end
