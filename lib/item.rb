require 'bigdecimal'
require 'time'

class Item
  attr_accessor :specs

  def initialize(item = {})
    @specs = {
      id:           item[:id].to_i,
      name:         item[:name],
      description:  item[:description],
      unit_price:   BigDecimal(item[:unit_price]),
      created_at:   item[:created_at],
      updated_at:   item[:updated_at],
      merchant_id:  item[:merchant_id].to_i
    }
  end

  def id
    @specs[:id]
  end

  def name
    @specs[:name]
  end

  def description
    @specs[:description]
  end

  def unit_price
    @specs[:unit_price] / 100
  end

  def created_at
    Time.parse(@specs[:created_at].to_s)
  end

  def updated_at
    Time.parse(@specs[:updated_at].to_s)
  end

  def merchant_id
    @specs[:merchant_id]
  end

  def unit_price_to_dollars
    unit_price.to_f
  end
end
