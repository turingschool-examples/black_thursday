class InvoiceItem

  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  attr_accessor :repository

  def initialize(row, repository = nil)
    @id           = row[:id].to_i
    @item_id      = row[:item_id].to_i
    @invoice_id   = row[:invoice_id].to_i
    @quantity     = row[:quantity].to_i
    @unit_price   = BigDecimal.new(row[:unit_price], 4) / 100
    @created_at   = Time.parse(row[:created_at])
    @updated_at   = Time.parse(row[:updated_at])
    @repository   = repository
  end

  def unit_price_to_dollars
  repository.sales_engine.items.find_by_id(self.item_id).to_f
  end
end
