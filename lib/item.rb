require 'bigdecimal'
require 'time'

class Item
  attr_accessor :attributes

  def initialize(item_data)
    @attributes = {
      id:           item_data[:id].to_i,
      name:         item_data[:name],
      description:  item_data[:description],
      unit_price:   BigDecimal(item_data[:unit_price]),
      created_at:   item_data[:created_at],
      updated_at:   item_data[:updated_at],
      merchant_id:  item_data[:merchant_id].to_i
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
