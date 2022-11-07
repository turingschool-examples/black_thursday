require_relative 'make_time'

class InvoiceItem
  include MakeTime

  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(invoice_item_data)
    @id = invoice_item_data[:id]
    @item_id = invoice_item_data[:item_id]
    @invoice_id = invoice_item_data[:invoice_id]
    @quantity = invoice_item_data[:quantity]
    @unit_price = BigDecimal((invoice_item_data[:unit_price].to_f / 100), 4)
    @created_at = invoice_item_data[:created_at]
    @updated_at = invoice_item_data[:updated_at]
  end

  def unit_price_to_dollars 
    "$#{@unit_price.to_f}"
  end
end
