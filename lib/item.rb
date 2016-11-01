require 'bigdecimal'
require 'pry'
class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(item_data)
    @id          = item_data[:id].to_i
    @name        = item_data[:name]
    @description = item_data[:description]
    @unit_price  = BigDecimal(item_data[:unit_price].to_f / 100.0, 4)
    @created_at  = (item_data[:created_at].to_s)
    @updated_at  = (item_data[:updated_at].to_s)
    @merchant_id = item_data[:merchant_id].to_i
  end
end
