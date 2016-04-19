require 'bigdecimal'

class Item
  attr_reader :id, :name, :description, :merchant_id, :unit_price

  def initialize(item_hash = {})
    @id = item_hash.fetch(:id)
    @name = item_hash.fetch(:name)
    @description = item_hash.fetch(:description)
    @unit_price = item_hash.fetch(:unit_price)
    @created_at = item_hash.fetch(:created_at)
    @updated_at = item_hash.fetch(:updated_at)
    @merchant_id = item_hash.fetch(:merchant_id)
  end

  def unit_price_to_dollars
    dollar_price = @unit_price.to_f
  end

end
