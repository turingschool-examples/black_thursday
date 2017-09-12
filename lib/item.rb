require 'bigdecimal'

class Item

  def self.load_csv(items)
    id = items[:id]
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
    @unit_price = unit_price
    @created_at = created_at
    @updated_at = updated_at
    @merchant_id = merchant_id
  end

  def unit_price_to_dollars(unit_price)
    unit_price.to_f
  end
end
