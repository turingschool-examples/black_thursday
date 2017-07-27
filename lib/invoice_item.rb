class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(invoice_items, invoice_items_repo)
    @id         = invoice_items[:id]
    @item_id    = invoice_items[:item_id]
    @invoice_id = invoice_items[:invoice_id]
    @quantity   = invoice_items[:quantity]
    @unit_price = invoice_items[:unit_price]
    @created_at = invoice_items[:created_at]
    @updated_at = invoice_items[:updated_at]
  end


end
