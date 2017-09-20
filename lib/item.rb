require 'bigdecimal'
require 'time'
require 'pry'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :price,
              :parent

  def initialize(item,repo=nil)
    @id = item[:id].to_i
    @name = item[:name]
    @description = item[:description]
    @price = BigDecimal.new(item[:unit_price])
    @unit_price = unit_price_to_dollars(@price)
    @merchant_id = item[:merchant_id].to_i
    @created_at = Time.parse(item[:created_at].to_s)
    @updated_at = Time.parse(item[:updated_at].to_s)
    @parent = repo
  end

  def unit_price_to_dollars(unit_price)
    unit_price / 100
  end

  def merchant
    parent.item_merchant(self.merchant_id)
  end

end
