require 'time'

class Item
  attr_reader   :id,
                :created_at,
                :merchant_id

  attr_accessor :name,
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
end
