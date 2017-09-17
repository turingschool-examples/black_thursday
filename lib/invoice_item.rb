require 'bigdecimal'
require 'time'

class InvoiceItem

  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity, #this is here for testing purposes
              :unit_price,
              :created_at,
              :updated_at

  def initialize(info, invoice_item_repository)
    @id = info[:id].to_i
    @item_id = info[:item_id].to_i
    @invoice_id = info[:invoice_id].to_i
    @quantity = info[:quantity].to_i
    @unit_price = BigDecimal.new(info[:unit_price], 4)/100
    @created_at = Time.parse(info[:created_at])
    @updated_at = Time.parse(info[:updated_at])
    @invoice_item_repository = invoice_item_repository
  end

  def unit_price_to_dollars
    @unit_price.to_f / 100
  end
end
