require 'bigdecimal'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :created_at,
              :repository
  attr_accessor :updated_at,
                :quantity
  attr_writer :cent_price

  def initialize(invoice_item_info)
    @id = invoice_item_info[:id].to_i
    @item_id = invoice_item_info[:item_id].to_i
    @invoice_id = invoice_item_info[:invoice_id].to_i
    @quantity = invoice_item_info[:quantity].to_i
    @cent_price = BigDecimal(invoice_item_info[:cent_price], 10)
    @created_at = invoice_item_info[:created_at]
    @updated_at = invoice_item_info[:updated_at]
    @repository = repository
  end

  def unit_price
    @cent_price / 100
  end

  def unit_price_to_dollars
    unit_price.to_f.round(2)
  end
end
