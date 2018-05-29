require 'time'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(item)
    @id = item[:id]
    @name = item[:name]
    @description = item[:description]
    @unit_price = BigDecimal(item[:unit_price]) / 100
    @merchant_id = item[:merchant_id]
    @created_at = item[:created_at]
    @updated_at = item[:updated_at]
  end

  def update_name(name)
    @name = name
  end

  def update_description(description)
    @description = description
  end

  def update_unit_price(new_price)
    @unit_price = new_price
  end

  def update_updated_at(new_time)
    @updated_at = new_time
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
