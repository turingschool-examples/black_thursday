require 'bigdecimal'
require 'time'

class Item
  attr_reader     :id,
                  :created_at,
                  :merchant_id
  attr_accessor   :name,
                  :description,
                  :updated_at,
                  :unit_price

  def initialize(attributes)
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @description = attributes[:description]
    @unit_price = BigDecimal.new(attributes[:unit_price],4)
    @created_at = Time.now
    @updated_at = Time.now
    @merchant_id = attributes[:merchant_id]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
