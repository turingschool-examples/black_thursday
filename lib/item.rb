# require "./big_decimal"
require 'time'
class Item
  def initialize(args)
    @id = args[:id]
    @name = args[:name]
    @description  = args[:description]
    @unit_price = args[:unit_price]
    @created_at = args[:created_at]
    @updated_at = args[:updated_at]
    @merchant_id = args[:merchant_id]
  end




end
