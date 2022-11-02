class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(ii_input)
    @id = ii_input[:id]
    @item_id = ii_input[:item_id]
    @invoice_id = ii_input[:invoice_id]
    @quantity = ii_input[:quantity]
    @unit_price = ii_input[:unit_price]
    @created_at = ii_input[:created_at]
    @updated_at = ii_input[:updated_at]
  end

  

end