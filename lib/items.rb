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


  def initialize(data, repo = nil)
    @id          = data[:id].to_i
    @name        = data[:name]
    @description = data[:description]
    @price       = BigDecimal.new(data[:unit_price])
    @unit_price  = unit_price_to_dollars(@price)
    @created_at  = Time.parse(data[:created_at].to_s)
    @updated_at  = Time.parse(data[:updated_at].to_s)
    @merchant_id = data[:merchant_id].to_i
    @parent      = repo
  end

  def unit_price_to_dollars(unit_price)
    unit_price / 100
  end

  def merchant
    parent.merchant_item(merchant_id)
  end
end
