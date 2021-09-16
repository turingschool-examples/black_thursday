require 'csv'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(info)
    @id          = info[:id]
    @name        = info[:name]
    @unit_price  = info[:unit_price]
    @created_at  = info[:created_at]
    @updated_at  = info[:updated_at]
    @description = info[:description]
    @merchant_id = info[:merchant_id]
  end
end
