class InvoiceItem
attr_reader :id,
            :item_id,
            :invoice_id,
            :quantity,
            :quantity,
            :unit_price,
            :created_at,
            :updated_at
            
  def initialize(ii_data)
    @id = ii_data[:id].to_i
    @item_id = ii_data[:item_id].to_i
    @invoice_id = ii_data[:invoice_id].to_i
    @quantity = ii_data[:quantity].to_i
    @unit_price = ii_data[:unit_price].to_f
    @created_at = ii_data[:created_at]
    @updated_at = ii_data[:updated_at]
  end
end
