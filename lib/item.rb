require 'pry'

require 'bigdecimal'

require_relative 'data_typing'


class Item
  include DataTyping

  attr_reader :id,
              :created_at,
              :merchant_id

  attr_accessor :name,
                :description,
                :unit_price,
                :updated_at

  def initialize(hash)
    # -- Read Only --
    @id           = make_integer(hash[:id])
    @created_at   = make_time(hash[:created_at])
    @merchant_id  = make_integer(hash[:merchant_id])
    # -- Accessible --
    @name         = hash[:name]                           if hash[:name]
    @description  = hash[:description]                    if hash[:description]
    @unit_price   = make_big_decimal(hash[:unit_price])   if hash[:unit_price]
    @updated_at   = make_time(hash[:updated_at])          if hash[:updated_at]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def make_updates(hash)
    @name        = hash[:name]                         if hash[:name]
    @description = hash[:description]                  if hash[:description]
    @unit_price  = make_big_decimal(hash[:unit_price]) if hash[:unit_price]
    @updated_at  = make_time(hash[:updated_at])        if hash[:updated_at]
    @updated_at  = make_time(Time.now)                 if hash[:updated_at] == nil
  end


end
