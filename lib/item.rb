class Item
 attr_reader :name,
             :id,
             :description,
             :unit_price,
             :created_at,
             :updated_at,
             :merchant_id

  def initialize(data)
   @id          = data[:id]
   @name        = data[:name]
   @description = data[:description]
   @unit_price  = BigDecimal.new(data[:unit_price],4)
   @created_at  = data[:created_at]
   @updated_at  = data[:updated_at]
   @merchant_id = data[:merchant_id]
   #ask Sal about merchant_id -- why wasn't it included in the specs?
  end

  def unit_price_to_dollars
    unit_price
  end

end
