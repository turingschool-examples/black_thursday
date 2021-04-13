require 'bigdecimal'
require 'date'
class Item
  attr_reader :id,
  :name,
  :description,
  :unit_price,
  :created_at,
  :updated_at,
  :merchant_id

  def initialize(row)
    @id = (row[:id]).to_i
    @name = row[:name]
    @description = row[:description]
    @unit_price = BigDecimal(row[:unit_price])
    @created_at = Time.parse(row[:created_at])
    @updated_at = Time.parse(row[:updated_at])
    @merchant_id = (row[:merchant_id]).to_i
  end
end
