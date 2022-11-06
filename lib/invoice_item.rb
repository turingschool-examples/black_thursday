require 'bigdecimal'

class InvoiceItem
  attr_reader :id,
              :item_id

  def initialize(attributes)
    @id      = attributes[:id]
    @item_id = attributes[:item_id]
  end
end
