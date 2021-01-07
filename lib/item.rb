class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,


  def initialize(info)
    @id = info[:id].to_i
    @name = info[:name]
    @description = info[:description]
    @unit_price = info[:unit_price].to_f(2)
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
    @merchant_id = info[:merchant_id]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
