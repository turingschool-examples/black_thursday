require "time"
require "bigdecimal"

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :invoice_item_repo

  def initialize(row, invoice_item_repo)
    @id           = row[:id]
    @item_id      = row[:item_id]
    @invoice_id   = row[:invoice_id]
    @quantity     = row[:quantity]
    @unit_price   = BigDecimal.new(row[:unit_price]) / 100.00
    @created_at   = Time.parse(row[:created_at])
    @updated_at   = Time.parse(row[:updated_at])
    @invoice_item_repo = invoice_item_repo
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def item
    invoice_item_repo.find_item_by_item_id(self.item_id)
  end
end
