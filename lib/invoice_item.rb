class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at


  def initialize(invoice_items_hash)
      @id = invoice_items_hash[:id]
      @item_id = invoice_items_hash[:item_id]
      @invoice_id = invoice_items_hash[:invoice_id]
      @quantity = invoice_items_hash[:quantity]
      @unit_price = BigDecimal(invoice_items_hash[:unit_price].to_i)/100
      @created_at = invoice_items_hash[:created_at]
      @updated_at = invoice_items_hash[:updated_at]
  end

  def unit_price_to_dollars
    @unit_price.to_f.round(2)
  end


end
