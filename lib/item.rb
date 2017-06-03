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
    @created_at = date_convert(information[:created_at])
    @updated_at = date_convert(information[:updated_at])
    @merchant_id = information[:merchant_id].to_i
    @parent = parent
  end

  def date_convert(from_file)
    date = from_file.split(/[-," ",:]/)
    time = Time.utc(date[0], date[1], date[2], date[3], date[4], date[5])
  end
end
