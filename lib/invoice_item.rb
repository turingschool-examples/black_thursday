class InvoiceItem
  attr_reader :invoice_item_attributes

  def initialize(attributes)
    @invoice_item_attributes = attributes
  end

  def unit_price_to_dollars
    invoice_item_attributes[:unit_price].to_f
  end
end
