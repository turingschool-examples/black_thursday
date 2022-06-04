class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :created_at

  attr_accessor :unit_price,
                :updated_at,
                :quantity


  def initialize(details)
    @id = details[:id]
    @item_id = details[:item_id]
    @invoice_id = details[:invoice_id]
    @quantity = details[:quantity]
    @unit_price = details[:unit_price]
    @created_at = details[:created_at]
    @updated_at = details[:updated_at]
  end

  def unit_price_to_dollars
    @unit_price.round(2)
  end

end
