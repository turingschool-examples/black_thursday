require 'bigdecimal'
require 'time'

class Item
  attr_accessor :id,
                :name,
                :description,
                :unit_price,
                :created_at,
                :updated_at,
                :merchant_id

  def initialize(attributes)
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @description = attributes[:description]
    @unit_price = if attributes[:unit_price].class == BigDecimal
                    attributes[:unit_price]
                  else
                    BigDecimal(attributes[:unit_price])/100
                  end
    @created_at = if attributes[:created_at].class == Time
                    attributes[:created_at]
                  else
                    Time.parse(attributes[:created_at])
                  end
    @updated_at = if attributes[:updated_at].class == Time
                    attributes[:updated_at]
                  else
                    Time.parse(attributes[:updated_at])
                  end
    @merchant_id = attributes[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

end
