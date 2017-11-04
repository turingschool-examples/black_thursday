require 'time'
class InvoiceItemRepository
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(attributes, parent)
    @id           = attributes[:id].to_i
    @item_id      = attributes[:item_id].to_i
    @invoice_id   = attributes[:invoice_id].to_i
    @quantity     = attributes[:quantity].to_i
    @created_at   = Time.parse(attributes[:created_at])
    @updated_at   = Time.parse(attributes[:updated_at])
    @parent       = parent
  end
end
