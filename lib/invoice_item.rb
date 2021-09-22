# frozen_string_literal: true
require 'bigdecimal'
require 'time'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at


  def initialize(info)
    @id           = info[:id].to_i
    @item_id      = info[:item_id].to_i
    @invoice_id   = info[:invoice_id].to_i
    @quantity     = info[:quantity].to_i
    @unit_price   = BigDecimal(info[:unit_price], 4) / 100
    @created_at   = Time.parse(info[:created_at])
    @updated_at   = Time.parse(info[:updated_at])
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def change_unit_price(new_price)
    @unit_price = new_price
    @updated_at = Time.now.utc
  end

  def change_quantity(quantity)
    @quantity = quantity
    @updated_at = Time.now.utc
  end
end
