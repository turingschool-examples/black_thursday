class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at 

  def initialize(arg)
    @id           = arg[:id]
    @name         = arg[:name]
    @description  = arg[:description]
    @unit_price   = arg[:unit_price]
    @merchant_id  = arg[:merchant_id]
    @created_at   = arg[:created_at]
    @updated_at   = arg[:updated_at]
  end

  def unit_price_as_dollars
    sprintf('%05.2f', (@unit_price/100)).to_f
  end

end