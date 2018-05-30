require 'bigdecimal'
require 'time'

class Item
  attr_accessor     :id,
                    :merchant_id,
                    :name,
                    :description,
                    :unit_price,
                    :created_at,
                    :updated_at,
                    :unit_price_to_dollars,
                    :merchant_id

  def initialize(item_attributes)
    @id = item_attributes[:id].to_i
    @merchant_id = item_attributes[:merchant_id].to_i
    @name = item_attributes[:name]
    @description = item_attributes[:description]
    @unit_price = BigDecimal.new(item_attributes[:unit_price].to_i) / 100
    @created_at = time_conversion(item_attributes[:created_at])
    @updated_at = time_conversion(item_attributes[:updated_at])
  end

  def time_conversion(time)
    if time.class == String
      time = Time.parse(time)
    end
    time
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
