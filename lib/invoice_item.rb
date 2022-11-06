require 'bigdecimal'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id

  def initialize(attributes)
    @id      = attributes[:id]
    @item_id = attributes[:item_id]
    @invoice_id = attributes[:invoice_id]
  end
end
