class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :irr

  def initialize(id, item_id, invoice_id,
                quantity, unit_price, created_at,
                updated_at, iir)
    @id = id
    @item_id = item_id
    @invoice_id = invoice_id
    @quantity = quantity
    @unit_price = BigDecimal.new(unit_price.insert(-3, "."))
    @created_at = Time.parse(created_at)
    @updated_at = Time.parse(updated_at)
    @iir = irr
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
  
end
