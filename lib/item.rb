require 'bigdecimal'
require 'time'

class Item

attr_reader :id, :merchant_id, :created_at, :unit_price_to_dollars
attr_accessor :name, :description, :unit_price, :updated_at

  def initialize(data)
    @id = data[:id].to_i
    @name = data[:name]
    @description = data[:description]
    @unit_price = BigDecimal(data[:unit_price])/100
    @merchant_id = data[:merchant_id].to_i
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @unit_price_to_dollars = data[:unit_price].to_f
  end

end
