require 'bigdecimal'
require 'bigdecimal/util'
require 'time'

class Item
  attr_reader   :id,
                :created_at,
                :merchant_id

  attr_accessor :name,
                :description,
                :unit_price,
                :updated_at

  def initialize(item_hash)
    @name = item_hash[:name]
    @description = item_hash[:description]
    @id = item_hash[:id].to_i
    @unit_price = BigDecimal(item_hash[:unit_price].to_i) / 100
    @created_at = Time.parse(item_hash[:created_at])
    @updated_at = Time.parse(item_hash[:updated_at])
    @merchant_id = item_hash[:merchant_id]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
