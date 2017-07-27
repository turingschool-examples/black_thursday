require 'bigdecimal'
require 'time'

class Item

  attr_reader :id,
              :name,
              :description,
              :price,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(item_hash, item_repository)
    @item_hash =       item_hash
    @item_repository = item_repository
    @id =              @item_hash[:id].to_i
    @name =            @item_hash[:name]
    @description =     @item_hash[:description]
    @price =           BigDecimal.new(item_hash[:unit_price])
    @unit_price =      unit_price_in_dollars(@price)
    @merchant_id =     @item_hash[:merchant_id]
    @created_at =      Time.parse(item_hash[:created_at])
    @updated_at =      Time.parse(item_hash[:updated_at])
  end

  def unit_price_in_dollars(unit_price)
    unit_price / 100
  end

  def merchant
    @item_repository.sales_engine.merchants.find_by_id(@merchant_id.to_i)
  end
end
