require 'bigdecimal'
require 'time'
require 'pry'

class InvoiceItem

  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(row, parent)
    @id            = row[:id].to_i
    @item_id       = row[:item_id].to_i
    @invoice_id    = row[:invoice_id].to_i
    @quantity      = row[:quantity].to_i
    @unit_price    = BigDecimal.new(row[:unit_price], 4) / 100
    @created_at    = Time.parse(row[:created_at])
    @updated_at    = Time.parse(row[:updated_at])
    @inv_item_repo = parent
  end

  def unit_price_to_dollars
    (unit_price.to_f * 100).round(2)
  end


end
