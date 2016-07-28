require 'bigdecimal'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(item, item_repository_parent = nil)
    @item_repository_parent = item_repository_parent
    @id                     = item[:id].to_i
    @name                   = item[:name]
    @description            = item[:description]
    @unit_price             = BigDecimal.new(item[:unit_price]) / 100
    @created_at             = Time.parse(item[:created_at])
    @updated_at             = Time.parse(item[:updated_at])
    @merchant_id            = item[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @unit_price
  end
end
