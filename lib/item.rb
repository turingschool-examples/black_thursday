require 'pry'
require 'time'
require 'bigdecimal'

class Item
  attr_reader :name, :id, :description, :unit_price, :created_at, :updated_at, :merchant_id, :engine

  def initialize(item_info, engine = nil)
    @name          = item_info[:name]
    @id            = item_info[:id].to_i
    @description   = item_info[:description]
    @unit_price    = BigDecimal.new((item_info[:unit_price].to_f), 4)
    @created_at    = Time.parse(item_info[:created_at])
    @updated_at    = Time.parse(item_info[:updated_at])
    @merchant_id   = item_info[:merchant_id].to_i
    @engine        = engine
  end

  def unit_price_to_dollars
    (unit_price.to_f / 100).to_f
  end

  def merchant
    #Etsy owner's merchant ID needs to pop up here per every item made
    @engine.merchants.find_by_id(self.merchant_id)
  end
end
