require 'pry'
require 'bigdecimal'
require 'time'
class Item
  attr_reader :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,
              :parent

  def initialize(information,parent)
    @name = information[:name]
    @description = information[:description]
    @unit_price = BigDecimal(information[:unit_price].to_i)
    @created_at = information[:created_at]
    @updated_at = information[:updated_at]
    @merchant_id = information[:merchant_id].to_i
    @parent = parent
  end

  # def convert_time(time)
  #   list = time.split(/[- :]/)
  #   final = Time.utc(list[0].to_i, list[1].to_i, list[2].to_i, list[3].to_i, list[4].to_i, list[5].to_i)
  # end

end
