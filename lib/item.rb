class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :parent 

  def initialize(arg, parent)
    @id           = arg[:id]
    @name         = arg[:name]
    @description  = arg[:description]
    @unit_price   = arg[:unit_price]
    @merchant_id  = arg[:merchant_id]
    @created_at   = arg[:created_at]
    @updated_at   = arg[:updated_at]
    @parent = parent
  end

  def unit_price_as_dollars
    sprintf('%05.2f', (@unit_price/100)).to_f
  end

  def merchant
    parent.find_merchant_by_merchant_id(merchant_id)
  end

end