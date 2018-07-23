require 'bigdecimal'
require 'bigdecimal/util'
require 'time'


class Item
  attr_reader   :id,
                :merchant_id
  attr_accessor :name,
                :description,
                :unit_price

  def initialize(information)
    @id = information[:id].to_i
    @name = information[:name]
    @description = information[:description]
    @unit_price = (information[:unit_price].to_f / 100).to_d
    @merchant_id = information[:merchant_id].to_i
    @created_at = information[:created_at]
    @updated_at = information[:updated_at]
  end

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
