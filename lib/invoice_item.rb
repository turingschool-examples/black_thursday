require 'bigdecimal'
require 'time'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :quantity,
              :invoice_id,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(data)
    @id = data[:id].to_i
    @item_id = data[:item_id].to_i
    @invoice_id = data[:invoice_id].to_i
    @unit_price = BigDecimal(data[:unit_price]) / 100
    @quantity = data[:quantity].to_i
    @created_at = Time.parse(data[:created_at].to_s)
    @updated_at = Time.parse(data[:updated_at].to_s)
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def update_quantity(new_quantity)
    @quantity = new_quantity
  end

  def update_unit_price(new_unit_price)
    @unit_price = new_unit_price
  end

  def new_update_time(new_time)
    @updated_at = new_time
  end
end
