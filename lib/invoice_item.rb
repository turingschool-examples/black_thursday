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

  def initialize(inv_item)
    @id            = inv_item[:id]
    @item_id       = inv_item[:item_id]
    @invoice_id    = inv_item[:invoice_id]
    @quantity      = inv_item[:quantity]
    @unit_price    = BigDecimal.new(inv_item[:unit_price], 4) / 100
    @created_at    = Time.parse(inv_item[:created_at])
    @updated_at    = Time.parse(inv_item[:updated_at])
    @inv_item_repo = inv_item[:inv_item_repo]
  end

  def self.creator(row, parent)
    new({
      id: row[:id].to_i,
      item_id: row[:item_id].to_i,
      invoice_id: row[:invoice_id].to_i,
      quantity: row[:quantity].to_i,
      unit_price: row[:unit_price],
      created_at: row[:created_at],
      updated_at: row[:updated_at],
      inv_item_repo: parent
    })
  end

  def unit_price_to_dollars
    (unit_price.to_f * 100).round(2)
  end


end
