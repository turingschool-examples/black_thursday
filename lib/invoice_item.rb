require 'time'
require 'bigdecimal'

class InvoiceItem
  attr_reader   :id,
                :item_id,
                :invoice_id,
                :quantity,
                :unit_price,
                :created_at,
                :updated_at

  def initialize(invoice_data, parent = nil)
    @invoice_parent = parent
    @id             = invoice_data[:id].to_i
    @item_id        = invoice_data[:item_id].to_i
    @invoice_id     = invoice_data[:invoice_id].to_i
    @quantity       = invoice_data[:quantity].to_i
    @unit_price     = find_unit_price(invoice_data[:unit_price])
    @created_at     = determine_the_time(invoice_data[:created_at])
    @updated_at     = determine_the_time(invoice_data[:updated_at])
  end

  def merchant
    @invoice_parent.parent.merchants.find_by_id(@merchant_id)
  end

  def find_unit_price(price)
    if unit_price == ""
      unit_price = BigDecimal.new(0)
    else
      unit_price = BigDecimal.new(price) / 100
    end
    unit_price
  end

  def unit_price_to_dollars(unit_price)
    @unit_price.to_f
  end

  def determine_the_time(time_string)
    time = Time.new(0)
    return time if time_string == ""
    time_string = Time.parse(time_string)
  end

end