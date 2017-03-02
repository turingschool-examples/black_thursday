require 'time'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :repo

  def initialize(row, repo)
    @id = row[:id].to_i
    @item_id = row[:item_id].to_i
    @invoice_id = row[:invoice_id].to_i
    @quantity = row[:quantity].to_i
    @unit_price = unit_price_to_dollars(row[:unit_price])
    @created_at = Time.parse(row[:created_at])
    @updated_at = Time.parse(row[:updated_at])
    @repo = repo
  end

  def unit_price_to_dollars(price)
    BigDecimal.new(price) / 100
  end

  def item
    repo.sales_engine.items.find_by_id(self.item_id)
  end

  def total_price
    quantity * unit_price
  end

end
