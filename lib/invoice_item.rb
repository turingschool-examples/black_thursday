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
              :item_and_quantity,
              :total_cost,
              :all_items

  def initialize(data, parent)
    @id = data[:id]
    @item_id = data[:item_id]
    @invoice_id = data[:invoice_id]
    @quantity = data[:quantity]
    @unit_price = BigDecimal.new(data[:unit_price]) / 100
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @total_cost = @unit_price * @quantity
    @all_items = Array.new(@quantity, @item_id)
    @invoice_item_repository = parent
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
