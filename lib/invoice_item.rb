require 'time'
require 'bigdecimal/util'
require 'bigdecimal'
class InvoiceItem

  attr_accessor :unit_price
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :created_at,
              :updated_at

  def initialize (data, repository)
    @id          = data[:id]
    @item_id     = data[:item_id]
    @invoice_id  = data[:invoice_id]
    @quantity    = data[:quantity]
    @unit_price  = data[:unit_price].to_d
    @created_at  = Time.parse(data[:created_at].to_s)
    @updated_at  = Time.parse(data[:updated_at].to_s)
    @repository  = repository
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def update_attributes (new_attributes)
    @quantity = new_attributes[:quantity]
    @unit_price = new_attributes[:unit_price]
  end
end
