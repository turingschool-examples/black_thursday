require "time"
require "bigdecimal"

class Item

  attr_accessor :id,
                :name,
                :description,
                :unit_price,
                :created_at,
                :updated_at,
                :merchant_id

  def initialize(hash)
    @id = hash[:id].to_i
    @name = hash[:name]
    @description = hash[:description]
    #require "pry"; binding.pry
    @unit_price = BigDecimal(hash[:unit_price])
    #require "pry"; binding.pry
    @created_at = Time.parse(hash[:created_at].to_s)
    @updated_at = Time.parse(hash[:updated_at].to_s)
    @merchant_id = hash[:merchant_id].to_i
  end

  def unit_price
    @unit_price / 100
  end

  def unit_price_to_dollars
    @unit_price.to_f / 100
  end


end
