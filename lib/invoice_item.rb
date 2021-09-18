class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(invoice_item)
    @id = invoice_item[:id]
    @item_id = invoice_item[:item_id]
    @invoice_id = invoice_item[:invoice_id]
    @quantity = invoice_item[:quantity]
    @unit_price = invoice_item[:unit_price]
    @created_at = invoice_item[:created_at]
    @updated_at = invoice_item[:updated_at]
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def update(quantity, unit_price)
    @updated_at = Time.now
    @quantity = quantity
    @unit_price = unit_price
    self
  end
end
