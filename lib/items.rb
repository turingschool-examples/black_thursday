require 'time'
require 'bigdecimal/util'
class Item

  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize (data)
    @id          = data[:id]
    @name        = data[:name]
    @description = data[:description]
    @unit_price  = data[:unit_price].to_d
    @merchant_id = data[:merchant_id]
    @created_at  = Time.parse(data[:created_at].to_s)
    @updated_at  = Time.parse(data[:updated_at].to_s)
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

end
