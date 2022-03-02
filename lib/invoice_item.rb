require 'bigdecimal'
class InvoiceItem
  attr_reader :invoice_item_attributes

  def initialize(attributes)
    @invoice_item_attributes = attributes
    @invoice_item_attributes[:id] = invoice_item_attributes[:id].to_i
    @invoice_item_attributes[:item_id] = invoice_item_attributes[:item_id].to_i
    @invoice_item_attributes[:invoice_id] = invoice_item_attributes[:invoice_id].to_i
    @invoice_item_attributes[:quantity] = invoice_item_attributes[:quantity].to_i
    @invoice_item_attributes[:unit_price] = invoice_item_attributes[:unit_price].to_i
  end

  def unit_price_to_dollars
    BigDecimal(invoice_item_attributes[:unit_price], 4)
  end
end
