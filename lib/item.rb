require 'bigdecimal'
class Item
  attr_reader :id, :name, :description, :unit_price_unedited, :created_at, :updated_at, :merchant_id, :engine

  def initialize(info = {}, item_repository = "")
    @id = info[:id]
    @name = info[:name]
    @description = info[:description]
    @unit_price_unedited = info[:unit_price]
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
    @merchant_id = info[:merchant_id]
    @engine = engine
  end
  
  # def unit_price
  #   BigDecimal.new((unit_price_unedited.to_i/100), 4)
  # end

  def unit_price_to_dollars
    unit_price.to_f
  end

end
