require 'bigdecimal'

class InvoiceItem
  attr_reader :item_id,
              :invoice_id,
              :quantity,
              :unit_price

  attr_accessor :id,
                :created_at,
                :updated_at

  def initialize(attributes, repo = nil)
    @id         = attributes[:id]
    @item_id    = attributes[:item_id]
    @invoice_id = attributes[:invoice_id]
    @quantity   = attributes[:quantity]
    @unit_price = attributes[:unit_price]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
    @repo       = repo
  end
end
