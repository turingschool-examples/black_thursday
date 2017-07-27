require 'time'
require 'bigdecimal'

class Item

  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,
              :price,
              :parent


  def initialize(hash, repo = nil)
    @id          = hash[:id].to_i
    @name        = hash[:name]
    @description = hash[:description]
    @price       = BigDecimal.new(hash[:unit_price])
    @unit_price  = unit_price_to_dollars(@price)
    @created_at  = Time.parse(hash[:created_at].to_s)
    @updated_at  = Time.parse(hash[:updated_at].to_s)
    @merchant_id = hash[:merchant_id].to_i
    @parent      = repo
  end

  def unit_price_to_dollars(unit_price)
    unit_price / 100
  end

  def merchant
    parent.merchant_item(self.merchant_id)
  end
end
