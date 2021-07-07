require 'time'
require 'bigdecimal'
require 'bigdecimal/util'

class InvoiceItem
  attr_reader :id,
              :created_at,
              :invoice_id,
              :item_id
  attr_accessor :unit_price,
                :quantity,
                :updated_at

  def initialize(hash)
    @id = hash[:id].to_i
    @item_id = hash[:item_id].to_i
    @invoice_id = hash[:invoice_id].to_i
    @quantity = hash[:quantity].to_i
    @unit_price = BigDecimal.new(hash[:unit_price].to_d/100)
    @created_at = Time.parse(hash[:created_at].to_s)
    @updated_at = Time.parse(hash[:updated_at].to_s)
  end

  def unit_price_to_dollars
    @unit_price.to_f.round(2)
  end
end
