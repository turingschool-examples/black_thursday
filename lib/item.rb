require 'bigdecimal'
require 'time'

class Item
  attr_accessor :attributes

  def initialize(hash = {})
    @attributes = {
    id:  hash[:id].to_i,
    name:         hash[:name],
    description:  hash[:description],
    unit_price:   BigDecimal(hash[:unit_price]),
    created_at:   hash[:created_at],
    updated_at:   hash[:updated_at],
    merchant_id:  hash[:merchant_id].to_i
    }
  end

  def id
    @attributes[:id]
  end

  def name
    @attributes[:name]
  end

  def description
    @attributes[:description]
  end

  def unit_price
    @attributes[:unit_price] / 100
  end

  def created_at
    Time.parse(@attributes[:created_at].to_s)
  end

  def updated_at
    Time.parse(@attributes[:updated_at].to_s)
  end

  def merchant_id
    @attributes[:merchant_id]
  end

  def unit_price_to_dollars
    unit_price.to_f
  end





end
