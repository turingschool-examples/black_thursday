require "bigdecimal"
require "time"

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,
              :repository

  def initialize(item_info, parent)
    @id          = item_info[:id].to_i
    @name        = item_info[:name]
    @description = item_info[:description]
    @unit_price  = (BigDecimal.new(item_info[:unit_price]))/100
    @created_at  = Time.parse(item_info[:created_at])
    @updated_at  = Time.parse(item_info[:updated_at])
    @merchant_id = item_info[:merchant_id].to_i
    @repository = parent
  end

  def merchant
    @repository.find_merchant(self.merchant_id)
  end

  def unit_price_to_dollars
    (unit_price).round(2).to_f
  end

  def unit_price_to_dollars()
    (unit_price / 100).round(2)
  end
end
