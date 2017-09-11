require 'bigdecimal'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id
              
  def initialize(info)
    @info        = info
    @id          = info[:id]
    @name        = info[:name]
    @description = info[:description]
    @unit_price  = BigDecimal.new(info[:unit_price]/100.0, 4)
    @created_at  = info[:created_at]
    @updated_at  = info[:updated_at]
    @merchant_id = info[:merchant_id]
  end

  # def unit_price_to_dollars
  #   if @unit_price.is_a?(Integer)
  # end
end