# frozen_string_literal: true

require 'time'
require 'bigdecimal'

# invoice item
class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :parent

  def initialize(data, parent)
    @id          = data[:id].to_i
    @item_id     = data[:item_id]
    @invoice_id  = data[:invoice_id]
    @quantity    = data[:quantity]
    @unit_price  = BigDecimal(data[:unit_price]) / 100.0
    @created_at  = Time.parse(data[:created_at])
    @updated_at  = Time.parse(data[:updated_at])
    @parent      = parent
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
