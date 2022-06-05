require 'helper'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :created_at

  attr_accessor :quantity,
                :unit_price
                :updated_at

  def initialize(input)
    @id = input[:id].to_i
    @item_id = input[:item_id].to_i
    @invoice_id = input[:invoice_id].to_i
    @quantity = input[:quantity].to_i
    @unit_price = input[:unit_price]
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
