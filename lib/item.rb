require 'bigdecimal'

class Item
  attr_accessor     :id,
                    :merchant_id,
                    :name,
                    :description,
                    :unit_price,
                    :created_at,
                    :updated_at,
                    :unit_price_to_dollars,
                    :merchant_id

  def initialize(item_attributes)
    @id = item_attributes[:id].to_i
    @merchant_id = item_attributes[:merchant_id].to_i
    @name = item_attributes[:name]
    @description = item_attributes[:description]
<<<<<<< HEAD
    @unit_price = BigDecimal.new(item_attributes[:unit_price].to_i/100)
    @created_at = Time.now
    @updated_at = Time.now
=======
    @unit_price = BigDecimal.new(item_attributes[:unit_price].to_i / 100)
    @created_at = item_attributes[:created_at]
    @updated_at = item_attributes[:updated_at]
>>>>>>> 51c1b436f3dbde6af94f71db5f98aced7ea278f7
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
