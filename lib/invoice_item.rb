require 'time'
require 'bigdecimal'

class InvoiceItem

attr_reader :id,
            :item_id,
            :invoice_id,
            :quantity,
            :unit_price,
            :created_at,
            :updated_at,
            :unit_price_to_dollars

  def initialize(data)
    @id = data[:id].to_i
    @item_id = data[:item_id].to_i
    @invoice_id = data[:invoice_id].to_i
    @quantity = data[:quantity].to_i
    @unit_price = BigDecimal(data[:unit_price])/100
    @created_at = Time.parse(data[:created_at].to_s)
    @updated_at = Time.parse(data[:updated_at].to_s)
    @unit_price_to_dollars = data[:unit_price].to_f
  end
end
