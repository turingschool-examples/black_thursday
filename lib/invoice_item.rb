require 'bigdecimal'
require 'time'
require_relative '../lib/type_conversion'

class InvoiceItem

  include TypeConversion
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :parent_repo

  def initialize(datum, parent_repo = nil)
    @id = datum[:id].to_i
    @item_id = datum[:item_id].to_i
    @invoice_id = datum[:invoice_id].to_i
    @quantity = datum[:quantity]
    @unit_price = convert_to_big_decimal(datum[:unit_price])
    @created_at = Time.parse(datum[:created_at])
    @updated_at = Time.parse(datum[:updated_at])
    @parent_repo = parent_repo
  end

  def unit_price_to_dollars
    unit_price.to_f
  end
end
