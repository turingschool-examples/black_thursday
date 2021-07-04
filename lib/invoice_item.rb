require 'time'

class InvoiceItem

  attr_reader     :id,
                  :item_id,
                  :invoice_id,
                  :quantity,
                  :unit_price,
                  :created_at,
                  :updated_at

  def initialize(attributes = {}, parent = nil)
    @id                  = attributes[:id].to_i
    @item_id             = attributes[:item_id].to_i
    @invoice_id          = attributes[:invoice_id].to_i
    @quantity            = attributes[:quantity].to_i
    @unit_price          = BigDecimal.new(attributes[:unit_price].to_i/100.0, 4)
    @created_at          = Time.parse(attributes[:created_at])
    @updated_at          = Time.parse(attributes[:updated_at])
    @invoice_item_repo   = parent
  end

  def unit_price_to_dollars
    unit_price
  end

end
