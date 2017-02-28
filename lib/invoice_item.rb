class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(invoice_item, parent)
    @id = invoice_item[:id].to_i
    @item_id = invoice_item[:item_id]
    @invoice_id = invoice_item[:invoice_id]
    @quantity = invoice_item[:quantity]
    @unit_price = invoice_item[:unit_price]
    @created_at = invoice_item[:created_at]
    @updated_at = invoice_item[:updated_at]
    # @created_at = Time.parse(invoice_item[:created_at])
    # @updated_at = Time.parse(invoice_item[:updated_at])
    @parent = parent
  end

  def unit_price_to_dollars
    @unit_price.to_f / 100
  end

end
