class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(data)
    @id = data[:id].to_i
    @name = data[:name]
    @description = data[:description]
    @unit_price = data[:unit_price].to_i
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @merchant_id = data[:merchant_id]
  end

  def unit_price_to_dollars
    @unit_price.to_f.round(2)
  end

end
