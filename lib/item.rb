require_relative 'item_repository'
class Item

  attr_reader :id, :created_at, :merchant_id

  attr_accessor :name, :description, :unit_price, :updated_at

  def initialize(item_hash)
    @id = item_hash[:id]
    @name = item_hash[:name]
    @description = item_hash[:description]
    @unit_price = item_hash[:unit_price]
    @created_at = item_hash[:created_at]
    @updated_at = item_hash[:updated_at]
    @merchant_id = item_hash[:merchant_id]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

end
