require 'csv'
require 'time'
require 'bigdecimal'
require_relative './item'
require_relative './item_repository'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id, 
              :quantity, 
              :unit_price,
              :created_at,
              :updated_at

  def initialize(info)
    @id = info[:id].to_i
    @item_id = info[:item_id].to_i
    @invoice_id = info[:invoice_id].to_i
    @quantity = info[:quantity].to_i
    @unit_price = BigDecimal(info[:unit_price], 4)
    @unit_price = (@unit_price / 100) if (@unit_price % 1).zero?
    @created_at = Time.parse(info[:created_at].to_s)
    @updated_at = Time.parse(info[:updated_at].to_s)
  end

  def unit_price_to_dollars
    unit_price.to_f
  end
end