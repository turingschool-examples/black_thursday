class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(item_characteristics)
    @id = item_characteristics[:id].to_i
    @name = item_characteristics[:name]
    @description = item_characteristics[:description]
    @unit_price = item_characteristics[:unit_price].to_i
    @merchant_id = item_characteristics[:merchant_id].to_i
    @created_at = item_characteristics[:created_at]
    @updated_at = item_characteristics[:updated_at]
  end
end
