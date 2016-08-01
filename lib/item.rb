require 'bigdecimal'
class Item
  attr_reader :name,
              :id,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id
  def initialize(input_item, parent = nil)
    @parent = parent
    @id = input_item[:id].to_i
    @name = input_item[:name]
    @description = input_item[:description]
    @unit_price = convert_unit_price(input_item[:unit_price])
    @created_at = input_item[:created_at].nil?? Time.now : Time.parse(input_item[:created_at])
    @updated_at = input_item[:updated_at].nil?? Time.now : Time.parse(input_item[:updated_at])
    @merchant_id = input_item[:merchant_id].to_i
  end

  def convert_unit_price(input_price)
    return BigDecimal.new(0) if input_price.nil?
    BigDecimal.new(input_price) / 100
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def merchant
    @parent.find_merchant_by_id(self.merchant_id)
  end
end
