require "bigdecimal"
require "time"
require 'pry'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :parent

  def initialize(item_data, parent)
              @id          = item_data[:id].to_i
              @item_id     = item_data[:item_id].to_i
              @invoice_id  = item_data[:invoice_id].to_i
              @quantity    = item_data[:quantity].to_i
              @unit_price  = BigDecimal.new(item_data[:unit_price])/100
              @created_at  = Time.parse(item_data[:created_at])
              @updated_at  = Time.parse(item_data[:updated_at])
              @parent      = parent
  end

  def unit_price_to_dollars
    @unit_price
  end

end
