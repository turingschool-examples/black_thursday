require 'bigdecimal'

class Item
  attr_reader :id, :name, :description, :merchant_id, :created_at, :updated_at

  def initialize(item_information)
    @id = item_information[:id]
    @name = item_information[:name]
    @description = item_information[:description]
    @unit_price = item_information[:unit_price]
    @merchant_id = item_information[:merchant_id]
    @created_at = item_information[:created_at]
    @updated_at = item_information[:updated_at]
  end

  def unit_price_to_dollars
    BigDecimal.new(@unit_price).to_f
  end


end
