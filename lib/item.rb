require 'bigdecimal'
require 'time'

class Item
  attr_accessor :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

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

  def update(id, attributes)
    item = find_item_by_id(id)
    unless item.nil?
      item[0].name        = attributes[:name] if attributes[:name]
      item[0].description = attributes[:description] if attributes[:description]
      item[0].unit_price  = attributes[:unit_price] if attributes[:unit_price]
      item[0].updated_at  = Time.now
    end
  end

end
