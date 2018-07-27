require 'time'
require 'bigdecimal'

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
    @unit_price = BigDecimal(hash[:unit_price].to_i)
      # require "pry"; binding.pry
    @created_at = if hash[:created_at].class == String
                  Time.parse(hash[:created_at])
                    else
                      Time.now
                  end
    @updated_at = if hash[:updated_at].class == String
                    Time.parse(hash[:updated_at])
                    else
                      Time.now
                    end
    @merchant_id = hash[:merchant_id].to_i
  end

  def unit_price
    @unit_price / 100
  end

  def unit_price_to_dollars
    @unit_price.to_f / 100
  end

end
