class InvoiceItem

  def initialize(data)
    @id = data[:id]
    @item_id = data[:merchant_id]
    @invoice_id = data[:invoice_id]
    @quantity = data[:quantity]
    @unit_price = data[:unit_price]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]

  end
end
