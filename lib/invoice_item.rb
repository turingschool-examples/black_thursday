require 'pry'

require 'bigdecimal'

require_relative 'data_typing'


class InvoiceItem
  include DataTyping

  attr_reader :id,
              :item_id,
              :invoice_id

  attr_accessor :quantity,
                :unit_price,
                :updated_at,
                :created_at

  def initialize(hash)
    # -- Read Only --
    @id         = make_integer(hash[:id])
    @item_id    = make_integer(hash[:item_id])
    @invoice_id = make_integer(hash[:invoice_id])
    # -- Accessible --
    @quantity   = make_integer(hash[:quantity])
    @unit_price = make_big_decimal(hash[:unit_price])
    @created_at = make_time(hash[:created_at])
    @updated_at = make_time(hash[:updated_at])
  end

  def unit_price_to_dollars
    # TO DO - Is this supposed to be 2 decimal places?
    @unit_price.to_f
  end


end
