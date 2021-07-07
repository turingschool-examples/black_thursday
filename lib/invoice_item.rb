# frozen_string_literal: false

require 'bigdecimal'
require 'time'
# Responsible for creating InvoiceItem objects
class InvoiceItem
  attr_reader   :id,
                :item_id,
                :invoice_id,
                :created_at
  attr_accessor :quantity,
                :unit_price,
                :updated_at

  def initialize(args)
    @id          = args[:id].to_i
    @item_id     = args[:item_id].to_i
    @invoice_id  = args[:invoice_id].to_i
    @quantity    = args[:quantity].to_i
    @unit_price  = BigDecimal(args[:unit_price]) / 100
    @created_at  = Time.parse(args[:created_at])
    @updated_at  = Time.parse(args[:updated_at])
  end

  def unit_price_to_dollars
    unit_price.to_f
  end
end
