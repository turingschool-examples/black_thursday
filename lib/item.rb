require 'bigdecimal'
require 'time'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,
              :parent

  def initialize(item_info = nil, repo = nil)
    return if item_info.to_h.empty?
    @parent      = repo
    @id          = item_info[:id].to_i
    @name        = item_info[:name].to_s
    @description = item_info[:description].to_s
    @price       = unit_price_to_dollars(item_info[:unit_price].to_s)
    @unit_price  = BigDecimal.new(@price, @price.to_s.length - 1)
    @created_at  = Time.parse(item_info[:created_at].to_s)
    @updated_at  = Time.parse(item_info[:updated_at].to_s)
    @merchant_id = item_info[:merchant_id].to_i
  end

  def unit_price_to_dollars(price)
    price.to_i / 100.0
  end

  def merchant
    parent.find_item_merchant_by_merch_id(@merchant_id)
  end

end