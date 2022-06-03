require 'BigDecimal'
class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(info)
    @id          = info[:id].to_i
    @name        = info[:name]
    @description = info[:description]
    @unit_price  = BigDecimal(info[:unit_price], 4)
    @created_at  = info[:created_at]
    @updated_at  = info[:updated_at]
    @merchant_id = info[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def update(attr)
    @name = attr[:name] unless attr[:name] == nil
    @description = attr[:description] unless attr[:description] == nil
    @unit_price = BigDecimal(attr[:unit_price], 4) unless attr[:unit_price] == nil
    @updated_at = Time.now
  end
end
