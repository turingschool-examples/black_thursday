class InvoiceItem

  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :parent

  def initialize(ii_data, parent = nil)
    @id = ii_data[:id]
    @item_id = ii_data[:item_id]
    @invoice_id = ii_data[:invoice_id]
    @quantity = ii_data[:quantity]
    @unit_price = ii_data[:unit_price]
    @created_at = ii_data[:created_at]
    @updated_at = ii_data[:updated_at]
    @parent = parent
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
