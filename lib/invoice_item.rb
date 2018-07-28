require 'time'
require 'bigdecimal'

class InvoiceItem

  attr_reader   :id,
                :item_id,
                :invoice_id,
                :created_at

  attr_accessor :quantity,
                :unit_price,
                :updated_at

  def initialize(info)
    @id = info[:id].to_i
    @item_id = info[:item_id].to_i
    @invoice_id = info[:invoice_id].to_i
    @quantity = info[:quantity].to_i
    @unit_price = BigDecimal(info[:unit_price]) / 100
    @created_at = Time.parse(info[:created_at].to_s)
    @updated_at = Time.parse(info[:updated_at].to_s)
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
