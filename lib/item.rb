require 'bigdecimal'
class Item

  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(information)
    @id = information[:id]
    @name = information[:name]
    @description = information[:description]
    @unit_price = BigDecimal.new(information[:unit_price])
    @created_at = information[:created_at]
    @updated_at = information[:updated_at]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

end
