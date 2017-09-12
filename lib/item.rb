require 'bigdecimal'

class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at

  def initialize(item)
    @id = item[:id]
    @name = item[:name]
    @description = item[:desciption]
    @unit_price = item[:unit_price]
    @merchant_id = item[:merchant_id]
    @created_at = item[:created_at]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

end
