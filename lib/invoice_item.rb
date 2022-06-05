class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(data_hash)
    @id = data_hash[:id].to_i
    @item_id = data_hash[:item_id]
    @invoice_id = data_hash[:invoice_id].to_i
    @quantity = data_hash[:quantity].to_i
    @unit_price = data_hash[:unit_price]
    @created_at = data_hash[:created_at]
    @updated_at = data_hash[:updated_at]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
