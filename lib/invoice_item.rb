require 'bigdecimal'
require 'bigdecimal/util'
require 'time'
require_relative 'repository'

class InvoiceItem
  attr_reader   :id,
                :item_id,
                :invoice_id,
                :created_at,
                :updated_at
  attr_accessor :quantity,
                :unit_price

  def initialize(information)
    @id         = information[:id].to_i
    @item_id    = information[:item_id].to_i
    @invoice_id = information[:invoice_id].to_i
    @quantity   = information[:quantity].to_i
    @unit_price = if information[:unit_price].class != BigDecimal
                    BigDecimal.new((information[:unit_price].to_f / 100), 10)
                  else
                    information[:unit_price]
                  end
    @created_at = Time.parse(information[:created_at].to_s)
    @updated_at = Time.parse(information[:updated_at].to_s)
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
