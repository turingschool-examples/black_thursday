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
    @unit_price = to_price(info[:unit_price])
    @created_at = to_time(info[:created_at])
    @updated_at = to_time(info[:updated_at])
  end

  def to_price(price)
    p = BigDecimal(price, 4)
    p = (p / 100) if (p % 1).zero?
    p
  end

  def to_time(time)
    Time.parse(time.to_s)
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def update(attributes)
    @quantity = attributes[:quantity] if attributes[:quantity]
    @unit_price = attributes[:unit_price] if attributes[:unit_price]
    @updated_at = Time.now
    self
  end
end
