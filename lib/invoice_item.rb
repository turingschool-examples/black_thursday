class InvoiceItem
  attr_reader :id, :item_id, :invoice_id, :created_at
  attr_accessor :quantity, :unit_price, :updated_at

  def initialize(info)
    @id = info[:id]
    @item_id = info[:item_id].to_i
    @invoice_id = info[:invoice_id].to_i
    @quantity = info[:quantity]
    @unit_price = BigDecimal(info[:unit_price ])/100
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
