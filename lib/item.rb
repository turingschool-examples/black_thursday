require 'bigdecimal'

class Item
  attr_accessor     :id,
                    :name,
                    :description,
                    :unit_price,
                    :created_at,
                    :updated_at,
                    :unit_price_to_dollars

  def initialize(item_attributes)
    @id = item_attributes[:id].to_i
    @name = item_attributes[:name]
    @description = item_attributes[:description]
    @unit_price = BigDecimal.new(item_attributes[:unit_price].to_i/100)
    @created_at = item_attributes[:created_at]
    @updated_at = item_attributes[:updated_at]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
