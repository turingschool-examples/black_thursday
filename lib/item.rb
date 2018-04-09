# item class
class Item
  attr_reader :id,
              :merchant_id,
              :created_at

attr_accessor :name,
              :description,
              :unit_price,
              :updated_at

  def initialize(item_hash = Hash.new(0))
    @id          = item_hash[:id]
    @name        = item_hash[:name]
    @description = item_hash[:description]
    @unit_price  = BigDecimal(item_hash[:unit_price], item_hash[:unit_price].to_s.length-1)
    @merchant_id = item_hash[:merchant_id].to_i
    @created_at  = item_hash[:created_at]
    @updated_at  = item_hash[:updated_at]
  end

  def set_unit_price_to_dollars
    @unit_price = @unit_price.to_f
  end
end
