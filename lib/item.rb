require 'bigdecimal'
require 'time'

class Item
  # id,name,description,unit_price,merchant_id,created_at,updated_at
  attr_reader :created_at, :updated_at, :id
  attr_accessor :name, :description, :unit_price

  def initialize(args)
    @id          = args[:id].to_i
    @name        = args[:name]
    @description = args[:description]
    @unit_price  = BigDecimal.new(args[:unit_price])/100
    @created_at  = Time.parse(args[:created_at])
    @updated_at  = Time.parse(args[:updated_at])
  end

  def unit_price_to_dollars
    unit_price.to_f
  end
end
