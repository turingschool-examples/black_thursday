require 'pry'

require 'bigdecimal'

require_relative 'data_typing'


class InvoiceItem
  include DataTyping

  attr_reader :id,
              :item_id,
              :invoice_id,
              :created_at

  attr_accessor :quantity,
                :unit_price,
                :updated_at

  def initialize(hash)
    # -- Read Only --
    @id         = make_integer(hash[:id])
    @item_id    = make_integer(hash[:item_id])
    @invoice_id = make_integer(hash[:invoice_id])
    @created_at = make_time(hash[:created_at])
    # -- Accessible --
    @quantity   = make_integer(hash[:quantity])
    @unit_price = make_big_decimal(hash[:unit_price])
    @updated_at = make_time(hash[:updated_at])
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def make_update(hash)
    @quantity = make_integer(hash[:quantity]) if hash[:quantity]
    @unit_price = make_big_decimal(hash[:unit_price]) if hash[:unit_price]
    @updated_at  = make_time(hash[:updated_at])        if hash[:updated_at]
    @updated_at  = make_time(Time.now)                 if hash[:updated_at] == nil
  end
end
