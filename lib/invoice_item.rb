require 'csv'
require 'bigdecimal'
require 'time'

class InvoiceItem

  attr_reader :id,
              :item_id,
              :invoice_id,
              :created_at

  attr_accessor :updated_at,
                :quantity,
                :unit_price

  def initialize(data)
    @id         = data[:id]
    @item_id    = data[:item_id]
    @invoice_id = data[:invoice_id]
    @quantity   = data[:quantity]
    @unit_price = data[:unit_price]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

end
