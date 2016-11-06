require_relative './data_parser'
require_relative './time_formatter'
require 'bigdecimal'

class InvoiceItem
    include TimeFormatter
    attr_reader :id,
                :item_id,
                :invoice_id,
                :quantity,
                :unit_price,
                :created_at,
                :updated_at

  def initialize(invoice_item_data, parent = nil)
    @id         = invoice_item_data[:id].to_i
    @item_id    = invoice_item_data[:item_id].to_i
    @invoice_id = invoice_item_data[:invoice_id].to_i
    @quantity   = invoice_item_data[:quantity].to_i
    @unit_price = BigDecimal(invoice_item_data[:unit_price].to_f / 100.0, 5)
    @created_at = format_time(invoice_item_data[:created_at].to_s)
    @updated_at = format_time(invoice_item_data[:updated_at].to_s)
    @parent     = parent
  end
end
