# item class
class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(item_hash = Hash.new(0))
    @id          = item_hash[:id]
    @name        = item_hash[:name]
    @description = item_hash[:description]
    @unit_price  = BigDecimal(item_hash[:unit_price], 4)
    @merchant_id = item_hash[:merchant_id].to_i
    @created_at  = item_hash[:created_at]
    @updated_at  = item_hash[:updated_at]
  end

  def set_unit_price_to_dollars
    @unit_price = @unit_price.to_f
  end
end
