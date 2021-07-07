require 'bigdecimal'
require 'time'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :created_at

  attr_accessor :quantity,
                :unit_price,
                :updated_at

  def initialize(invoice_item)
    @id = invoice_item[:id].to_i
    @item_id = invoice_item[:item_id].to_i
    @invoice_id = invoice_item[:invoice_id].to_i
    @quantity = invoice_item[:quantity].to_i
    @unit_price = BigDecimal(invoice_item[:unit_price]) / 100
    @created_at = Time.parse(invoice_item[:created_at].to_s)
    @updated_at = Time.parse(invoice_item[:updated_at].to_s)
  end

  def unit_price_to_dollars
    unit_price.to_f
  end
end
