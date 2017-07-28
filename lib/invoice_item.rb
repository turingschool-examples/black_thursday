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
    @unit_price = unit_price
    @created_at = Time.parse(created_at)
    @updated_at = Time.parse(updated_at)
    @iir = irr
  end
end
