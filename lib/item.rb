class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(item_data)
    @id = item_data[:id].to_i
    @name = item_data[:name]
    @description = item_data[:description]
    @unit_price = item_data[:unit_price]
    @created_at = item_data[:created_at]
    @updated_at = item_data[:updated_at]
    @merchant_id = item_data[:merchant_id]
  end

  def unit_price_to_dollars
    @unit_price.to_f.round(2)
  end

end
