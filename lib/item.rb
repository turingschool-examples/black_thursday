require 'time'
require 'bigdecimal'

class Item

  attr_reader :id, :merchant_id, :created_at
  attr_accessor :name, :description, :unit_price, :updated_at

  def initialize(info)
    @id = info[:id].to_i
    @name = info[:name]
    @description = info[:description]
    @unit_price = if info[:unit_price].class != "BigDecimal"
                    BigDecimal(info[:unit_price].to_f/100, 5)
                  else
                    info[:unit_price]
                  end
    @merchant_id = info[:merchant_id].to_i
    @created_at = Time.parse(info[:created_at])
    @updated_at = Time.parse(info[:updated_at])
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

end
