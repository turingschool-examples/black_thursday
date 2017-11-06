require "bigdecimal"
require "time"

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :unit_price,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :repository

  def initialize(item_info, parent)
    @id          = item_info[:id].to_i
    @item_id     = item_info[:item_id].to_i
    @invoice_id  = item_info[:invoice_id].to_i
    @quantity    = item_info[:quantity]
    @unit_price  = (BigDecimal.new(item_info[:unit_price]))/100
    @created_at  = Time.parse(item_info[:created_at])
    @updated_at  = Time.parse(item_info[:updated_at])
    @repository = parent
  end

  def merchant
    @repository.find_merchant(self.merchant_id)
  end

  def unit_price_to_dollars
    (unit_price).round(2).to_f
  end

  def unit_price_to_dollars()
    (unit_price / 100).round(2)
  end
end
