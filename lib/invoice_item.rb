require "bigdecimal"

class InvoiceItem

  attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at

  def initialize(data, parent = nil)
    @id = data[:id].to_i
    @item_id = data[:item_id].to_i
    @invoice_id = data[:invoice_id].to_i
    @quantity = data[:quantity].to_i
    @unit_price = BigDecimal.new(data[:unit_price].to_f/100,4)
    @created_at = Time.strptime(data[:created_at], "%Y-%m-%d %H:%M:%S %z") || Time.strptime(data[:created_at], "%Y-%m-%d")
    @updated_at = Time.strptime(data[:updated_at], "%Y-%m-%d %H:%M:%S %z") || Time.strptime(data[:created_at], "%Y-%m-%d")
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

end
