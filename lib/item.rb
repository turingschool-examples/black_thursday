require 'bigdecimal'
require 'time'

class Item
  attr_reader :id,
              :description,
              :created_at,
              :merchant_id

  attr_accessor :name,
                :description,
                :unit_price,
                :updated_at

  def initialize(item_data)
    @id = item_data[:id].to_i
    @name = item_data[:name]
    @description = item_data[:description]
    @unit_price = BigDecimal.new(item_data[:unit_price].to_i)/100
    @created_at = time_converter(item_data[:created_at])
    @updated_at = time_converter(item_data[:updated_at])
    @merchant_id = item_data[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @unit_price.to_f.round(2)
  end

  def time_converter(arguement)
    if arguement.class == String
      Time.parse(arguement)
    else
      arguement
    end
  end

end
