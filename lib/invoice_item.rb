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
              :invoice_item_repository

  def initialize(data, parent)
    @id                      = data[:id].to_i
    @item_id                 = data[:item_id].to_i
    @invoice_id              = data[:invoice_id].to_i
    @quantity                = data[:quantity].to_i
    @unit_price              = BigDecimal(data[:unit_price]) / 100
    @created_at              = Time.parse(data[:created_at])
    @updated_at              = Time.parse(data[:updated_at])
    @invoice_item_repository = parent
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def change_updated_at
    @updated_at = Time.now
  end

  def change_unit_price(unit_price)
    @unit_price = unit_price
  end

  def change_quantity(quantity)
    @quantity = quantity
  end
end
