# item class
class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(item_attributes_array)
    @id          = item_attributes_array[0]
    @name        = item_attributes_array[1]
    @description = item_attributes_array[2]
    @unit_price  = BigDecimal(item_attributes_array[3], 4)
    @merchant_id = item_attributes_array[4].to_i
    @created_at  = item_attributes_array[5]
    @updated_at  = item_attributes_array[6]
  end

  def set_unit_price_to_dollars
    @unit_price = @unit_price.to_f
  end
end
