require 'bigdecimal'
require 'time'

class Item
  attr_reader :id,
              :name,
              :updated_at,
              :description,
              :unit_price,
              :created_at,
              :merchant_id

  def initialize(row)
    @id = row[:id].to_i
    @name = row[:name]
    @description = row[:description]
    @unit_price = BigDecimal.new(row[:unit_price]) / 100
    @updated_at = Time.parse(row[:updated_at])
    @created_at = Time.parse(row[:created_at])
    @merchant_id = row[:merchant_id].to_i
  end
end
