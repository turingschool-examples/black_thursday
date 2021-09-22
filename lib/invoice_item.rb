require 'bigdecimal/util'
require_relative './sales_engine'

class InvoiceItem
  attr_reader   :id,
                :item_id,
                :invoice_id,
                :created_at
  attr_accessor :quantity,
                :unit_price,
                :updated_at

  def initialize(data)
    @id = data[0].to_i
    @item_id = data[1].to_i
    @invoice_id = data[2].to_i
    @quantity = data[3].to_i
    @unit_price = data[4].to_d / 100
    @created_at = Time.parse(data[5])
    @updated_at = Time.parse(data[6])
  end
end
