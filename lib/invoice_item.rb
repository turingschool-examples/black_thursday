class InvoiceItem

  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,

  attr_accessor :repository

  def initialize(row, repository = nil)
    @id           = row[:id]
    @item_id      = row[:item_id]
    @invoice_id   = row[:invoice_id]
    @quantity     = row[:quantity]
    @unit_price   = row[:unit_price]
    @created_at   = Time.parse(row[:created_at])
    @updated_at   = Time.parse(row[:updated_at])
    @repository   = repository
  end

  def unit_price_to_dollars
  repository.sales_engine.items.find_by_id
  end
end
