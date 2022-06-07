require 'BigDecimal'
class Item
  attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id
  attr_writer :name, :description, :unit_price, :updated_at
  def initialize(info)
    @id = info[:id].to_i
    @name = info[:name]
    @description = info[:description]
    @unit_price = BigDecimal(info[:unit_price])/100
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
    @merchant_id = info[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @unit_price.truncate(2).to_f
  end
end
