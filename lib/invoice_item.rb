require 'bigdecimal'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity

  def initialize(attributes)
    @id         = attributes[:id]
    @item_id    = attributes[:item_id]
    @invoice_id = attributes[:invoice_id]
    @quantity   = attributes[:quantity]
  end
end
