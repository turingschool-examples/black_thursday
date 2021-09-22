# frozen_string_literal: true

# this is the Invoice Item class for Black Thursday

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(invoice_item)
    @id = invoice_item[:id].to_i
    @item_id = invoice_item[:item_id].to_i
    @invoice_id = invoice_item[:invoice_id].to_i
    @quantity = invoice_item[:quantity].to_f
    @unit_price = invoice_item[:unit_price].to_f
    @created_at = invoice_item[:created_at]
    @updated_at = invoice_item[:updated_at]
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def update(quantity, unit_price)
    @updated_at = Time.now
    @quantity = quantity
    @unit_price = unit_price
    self
  end
end
