require 'bigdecimal/util'
require 'bigdecimal'
require 'time'

class Item
  attr_reader :id,
              :created_at,
              :merchant_id
  attr_accessor :name,
                :description,
                :unit_price,
                :updated_at

  def initialize(hash)
    @id = hash[:id].to_i
    @name = hash[:name]
    @description = hash[:description]
    @unit_price = BigDecimal.new(hash[:unit_price].to_d/100)
    @created_at = Time.parse(hash[:created_at].to_s)
    @updated_at = Time.parse(hash[:updated_at].to_s)
    @merchant_id = hash[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @unit_price.to_f.round(2)
  end

end
