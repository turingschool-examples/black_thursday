require 'bigdecimal'

class Item
  attr_reader :id, :created_at, :merchant_id
  attr_accessor :name, :description, :unit_price, :updated_at

  def initialize(info)
    @id = info[:id]
    @name = info[:name]
    @description = info[:description]
    @unit_price = info[:unit_price]
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
    @merchant_id = info[:merchant_id]
  end

  def unit_price_to_dollars
    @unit_price.to_f.round(2)
  end

end
