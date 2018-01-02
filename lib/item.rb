require 'pry'

class Item

  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(id, name, desc, price, merchant_id, created_at, updated_at)
    @id          = id
    @name        = name
    @description = desc
    @unit_price  = price
    @merchant_id = merchant_id
    @created_at  = created_at
    @updated_at  = updated_at
  end

  def unit_price_to_dollars

  end

end
