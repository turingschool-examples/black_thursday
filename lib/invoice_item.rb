class InvoiceItem

  def initialize(info, invoice_item_repository)
    @id = info[:id]
    @item_id = info[:item_id]
    @invoice_id = info[:invoice_id]
    @quantity = info[:quantity]
    @unit_price = info[:unit_price]
    @created_at = Time.parse(info[:created_at])
    @updated_at = Time.parse(info[:updated_at])
    @invoice_item_repository = invoice_item_repository
  end

  def unit_price_to_dollars
    @unit_price / 100
  end
end
