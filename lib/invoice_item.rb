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

  def initialize(data, parent = nil)
    @id =           data[:id].to_i
    @item_id =      data[:item_id].to_i
    @invoice_id =   data[:invoice_id].to_i
    @quantity =     data[:quantity].to_i
    @unit_price =   prep_unit_price(data[:unit_price])
    @created_at =   prep_time(data[:created_at])
    @updated_at =   prep_time(data[:updated_at])
    @parent     =   parent
  end

  def prep_time(time)
    return nil if !time
    Time.parse(time)
  end

  def prep_unit_price(unit_price)
    return nil if !unit_price
    digits = unit_price.length + 1
    value  = unit_price.to_i / 100.0
    BigDecimal.new(value, digits)
  end

  def unit_price_to_dollars
    unit_price.to_f
  end
end
