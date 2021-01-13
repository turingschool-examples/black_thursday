require 'bigdecimal'
require 'bigdecimal/util'
require 'time'
class Item
  attr_reader :id,
              :created_at,
              :merchant_id,
              :unit_price_to_dollars,
              :item_repo

  attr_accessor :name,
                :description,
                :unit_price,
                :updated_at

  def initialize(info, item_repo)
    @id = info[:id].to_i
    @name = info[:name]
    @description = info[:description]
    @unit_price = BigDecimal(info[:unit_price]) / 100
    @created_at = Time.parse(info[:created_at])
    @updated_at = Time.parse(info[:updated_at])
    @merchant_id = info[:merchant_id].to_i
    @unit_price_to_dollars = unit_price.to_f
    @item_repo = item_repo
  end
end
