class InvoiceItem
  attr_accessor :quantity, :unit_price
  attr_reader :id, :item_id, :invoice_id, :created_at, :updated_at
  def initialize(stats)
    @id = stats[:id]
    @item_id = stats[:item_id]
    @invoice_id = stats[:invoice_id]
    @quantity = stats[:quantity]
    @unit_price = stats[:unit_price]
    @created_at = stats[:created_at]
    @updated_at = stats[:updated_at]
  end
end
