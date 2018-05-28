require "bigdecimal"

class Item
  attr_accessor :specs

  def initialize(item = {})
    @specs = {
      id:           item[:id].to_i,
      name:         item[:name],
      description:  item[:description],
      unit_price:   BigDecimal(item[:unit_price]),
      created_at:   item[:created_at].to_s,
      updated_at:   item[:updated_at].to_s,
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
    @specs[:unit_price]
  end

  def created_at
    @specs[:created_at]
  end

  def updated_at
    @specs[:updated_at]
  end

  def merchant_id
    @specs[:merchant_id]
  end

end
