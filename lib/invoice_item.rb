class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(invoice_item_info)
    @id = invoice_item_info[:id]
    @item_id = invoice_item_info[:item_id]
    @invoice_id = invoice_item_info[:invoice_id]
    @quantity = invoice_item_info[:quantity]
    @unit_price = invoice_item_info[:unit_price]
    @created_at = invoice_item_info[:created_at]
    @updated_at = invoice_item_info[:updated_at]
  end

  def unit_price_to_dollars
    @unit_price.to_f.truncate(2)
  end

  def update_quantity(quantity)
    @quantity = quantity
  end

  def update_unit_price(number)
    @unit_price = number
  end 
end
