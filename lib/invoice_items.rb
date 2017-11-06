require "bigdecimal"
require "time"
#
# id - returns the integer id
# item_id - returns the item id
# invoice_id - returns the invoice id
# quantity - returns the quantity
# unit_price - returns the unit_price
# created_at - returns a Time instance for the date the invoice item was first created
# updated_at - returns a Time instance for the date the invoice item was last modified

class InvoiceItems
  attr_reader :id,
              :item_id
              :invoice_id
              :unit_price,
              :quantity
              :unit_price
              :created_at
              :updated_at
              :repository

  def initialize(item_info, parent)
    @id          = item_info[:id].to_i
    @item_id     = item_info[:item_id]
    @invoice_id  = item_info[:invoice_id]
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
