require "Time"

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(info)
    @id           = info[:id].to_i
    @name         = info[:name]
    @description  = info[:description]
    @unit_price   = BigDecimal(info[:unit_price], 4)
    @created_at   = Time.parse(info[:created_at])
    @updated_at   = Time.parse(info[:updated_at])
    @merchant_id  = info[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
