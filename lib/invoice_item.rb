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

  def initialize(inv_item)
    @id            = inv_item[:id].to_i
    @item_id       = inv_item[:item_id].to_i
    @invoice_id    = inv_item[:invoice_id].to_i
    @quantity      = inv_item[:quantity]
    @unit_price    = BigDecimal.new(inv_item[:unit_price], 4)
    @created_at    = inv_item[:created_at]
    @updated_at    = inv_item[:updated_at]
    @inv_item_repo = inv_item[:inv_item_repo]
  end

  def self.creator(row, parent)
    new({
      id: row[:id],
      item_id: row[:item_id],
      quantity: row[:quantity],
      unit_price: row[:unit_price],
      created_at: row[:created_at],
      updated_at: row[:updated_at],
      inv_item_repo: parent
    })
  end

  def unit_price_to_dollars
    (unit_price.to_f).round(2)
  end


end
