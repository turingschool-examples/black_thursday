require 'bigdecimal'
require 'time'

class Item

  def self.load_csv(items)
    id = items[:id].to_i
    name = items[:name]
    description = items[:description]
    unit_price = items[:unit_price]
    created_at = items[:created_at]
    updated_at = items[:updated_at]
    merchant_id = items[:merchant_id]
    Item.new(id,
             name,
             description,
             unit_price,
             created_at,
             updated_at,
             merchant_id)
  end

  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(id,
                 name,
                 description,
                 unit_price,
                 created_at,
                 updated_at,
                 merchant_id)
    @id = id
    @name = name
    @description = description
    @unit_price = unit_price_to_dollars(unit_price)
    @created_at = Time.parse(created_at)
    @updated_at = Time.parse(updated_at)
    @merchant_id = merchant_id
  end

  def unit_price_to_dollars(unit_price)
    dollars = unit_price.to_f / 100
    BigDecimal.new(dollars, 4)
  end

end
