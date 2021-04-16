class InvoiceItem

  def initialize(details)
    @id = details[:id]
    @item_id = details[:item_id]
    @invoice_id = details[:invoice_id]
    @quantity = details[:quantity]
    @unit_price = details[:unit_price]
    @created_at = details[:created_at]
    @updated_at = details[:updated_at]
  end

end