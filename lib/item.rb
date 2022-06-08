require 'bigdecimal'
require 'time'

class Item
attr_accessor :id,
              :name,
              :description,
              :created_at,
              :updated_at,
              :unit_price,
              :merchant_id

  def initialize(data_hash)
    @id = data_hash[:id].to_i
    @name = data_hash[:name]
    @description = data_hash[:description]
    @created_at = Time.parse(data_hash[:created_at])
    @updated_at = Time.parse(data_hash[:updated_at])
    @unit_price = BigDecimal(data_hash[:unit_price].to_f/100,4)
    @merchant_id = data_hash[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @unit_price.to_f.round(2)
  end
end
