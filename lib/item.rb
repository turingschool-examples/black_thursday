require 'bigdecimal'
require 'time'

class Item
 attr_reader :name,
             :id,
             :description,
             :unit_price,
             :created_at,
             :updated_at,
             :merchant_id

  def initialize(data, ir = nil)
   @ir          = ir
   @id          = data[:id]
   @name        = data[:name]
   @description = data[:description]
  #  @price       = BigDecimal.new(data[:unit_price])
   @unit_price  = BigDecimal.new(data[:unit_price], 4) /100
   @created_at  = Time.parse(data[:created_at])
   @updated_at  = Time.parse(data[:updated_at])
   @merchant_id = data[:merchant_id]
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  # def merchant
  #  @ir.merchant(merchant_id)
  #  require "pry"; binding.pry
  # end


end
