require 'pry'
require 'bigdecimal'
require 'time'
class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,
              :parent

  def initialize(information,parent)
    @id = information[:id].to_i
    @name = information[:name]
    @description = information[:description]
    @unit_price = BigDecimal(information[:unit_price].insert(-3, "."))
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
