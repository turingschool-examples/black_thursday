require 'time'

class Item
  attr_reader   :id,
                :created_at,
                :merchant_id,
                :name,
                :description,
                :unit_price,
                :updated_at

  def initialize(data)
    @id = data[:id].to_i
    @name = data[:name]
    @description = data[:description]
    @unit_price = BigDecimal(data[:unit_price]) / 100
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @merchant_id = data[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def update_name(name)
    @name = name
  end

  def update_description(description)
    @description = description
  end

  def update_up(up)
    @unit_price = up
  end

  def update_updated_at
    @updated_at = Time.now
  end
end
