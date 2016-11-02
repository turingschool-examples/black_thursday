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
    @id           = arg[:id].to_i
    @name         = arg[:name]
    @description  = arg[:description]
    @unit_price   = BigDecimal.new(arg[:unit_price].to_i) / 100
    @merchant_id  = arg[:merchant_id].to_i
    @created_at   = arg[:created_at]
    @updated_at   = arg[:updated_at]
    @parent = parent
  end

  def unit_price_as_dollars
    @unit_price.to_f
  end

  def merchant
    parent.find_merchant_by_merchant_id(merchant_id)
  end

end