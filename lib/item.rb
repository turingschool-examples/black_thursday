require 'pry'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(item_hash)
    @id          = item_hash[:id]
    @name        = item_hash[:name]
    @description = item_hash[:description]
    @unit_price  = item_hash[:unit_price]
    @merchant_id = item_hash[:merchant_id]
    @created_at  = item_hash[:created_at]
    @updated_at  = item_hash[:updated_at]
  end
end
