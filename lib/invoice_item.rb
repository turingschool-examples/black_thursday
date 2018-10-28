require 'bigdecimal'
require_relative './time_convert_module'

class InvoiceItem

  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  include TimeConvert

  def initialize(invoice_item_data)
    @id = invoice_item_data[:id].to_i
    @item_id = invoice_item_data[:item_id].to_i
    @invoice_id = invoice_item_data[:invoice_id].to_i
    @quantity = invoice_item_data[:quantity].to_i
    @unit_price = BigDecimal.new(invoice_item_data[:unit_price].to_i)/100
    @created_at = time_converter(invoice_item_data[:created_at])
    @updated_at = time_converter(invoice_item_data[:updated_at])
  end

  def unit_price_to_dollars
    @unit_price.to_f.round(2)
  end

end
