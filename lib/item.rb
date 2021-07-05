require 'bigdecimal'
require 'time'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :parent

  def initialize(data, parent)
    @id = data[:id].to_i
    @name = data[:name]
    @description = data[:description]
    @merchant_id = data[:merchant_id].to_i
    @created_at = Time.parse(data[:created_at].to_s)
    @updated_at = Time.parse(data[:updated_at].to_s)
    @parent = parent
    @unit_price = BigDecimal.new(data[:unit_price]) / 100
  end

  def update_name(name)
    @name = name
  end

  def update_unit_price(price)
    @unit_price = price
  end

  def update_description(description)
    @description = description
  end

  def new_update_time(time)
    @updated_at = time
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
