class Item
  attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id

  def initialize(item)
    @id = item[:id]
    @name = item[:name]
    @description = item[:description]
    @unit_price = item[:unit_price]
    @created_at = item[:created_at]
    @updated_at = item[:updated_at]
    @merchant_id = item[:merchant_id]
  end

  def unit_price_to_dollars
    return unit_price.to_f
  end
end