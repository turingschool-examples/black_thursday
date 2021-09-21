class InvoiceItem
  attr_reader :id, :item_id, :created_at, :invoice_id
  attr_accessor :quantity, :unit_price, :updated_at

  def initialize(data)
    @id           = (data[:id]).to_i
    @item_id      = data[:item_id].to_i
    @invoice_id   = data[:invoice_id].to_i
    @quantity     = data[:quantity].to_i
    @unit_price   = data[:unit_price].to_d
    @created_at   = data[:created_at]
    @updated_at   = data[:updated_at]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
