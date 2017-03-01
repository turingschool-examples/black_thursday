require 'bigdecimal'
require 'time'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :parent

  def initialize(path, parent)
    @id = path[:id].to_i
    @item_id = path[:item_id].to_i
    @invoice_id = path[:invoice_id].to_i
    @quantity = path[:quantity].to_i
    @unit_price = BigDecimal.new(path[:unit_price])/100
    @created_at = Time.parse(path[:created_at])
    @updated_at = Time.parse(path[:updated_at])
    @parent = parent
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
