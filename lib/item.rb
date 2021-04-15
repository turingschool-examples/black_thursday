require 'bigdecimal'

class Item
  attr_accessor :name,
                :description,
                :updated_at
  attr_reader :id,
              :created_at,
              :merchant_id,
              :repository

  def initialize(item_info)
    @id = item_info[:id].to_i
    @name = item_info[:name]
    @description = item_info[:description]
    @cent_price = BigDecimal(item_info[:cent_price],10)
    @created_at = item_info[:created_at]
    @updated_at = item_info[:updated_at]
    @merchant_id = item_info[:merchant_id].to_i
    @repository = repository
  end

  def unit_price
    @cent_price/100
  end

  def unit_price_to_dollars
    unit_price.to_f.round(2)
  end
end
