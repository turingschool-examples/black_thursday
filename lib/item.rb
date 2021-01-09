require 'bigdecimal'
require 'time'

class Item
  attr_reader :id,
              :created_at,
              :merchant_id

  attr_accessor :name,
                :description,
                :unit_price,
                :updated_at

  def initialize(data)
    @id          = data[:id]
    @name        = data[:name]
    @description = data[:description]
    @unit_price  = data[:unit_price]
    @created_at  = data[:created_at]
    @updated_at  = data[:updated_at]
    @merchant_id = data[:merchant_id]
  end

  def unit_price_to_dollars
    unit_price.round * 0.01
  end

  def update(attributes)
    @name        = attributes[:name] if attributes[:name]
    @description = attributes[:description] if attributes[:description]
    @unit_price  = attributes[:unit_price] if attributes[:unit_price]
    @updated_at  = Time.now
  end

end
