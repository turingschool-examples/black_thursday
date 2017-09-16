require 'bigdecimal'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :parent

  def initialize(info, parent = nil)
    @id = info[:id].to_i
    @item_id = info[:item_id].to_i
    @invoice_id = info[:invoice_id].to_i
    @quantity = info[:quantity].to_i
    @unit_price = BigDecimal.new(info[:unit_price])
    @created_at = Time.parse(info[:created_at])
    @updated_at = Time.parse(info[:updated_at])
    @parent = parent
  end
end
