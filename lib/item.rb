require 'pry'
class Item
  def initialize(data)
    @id  = data[:id]
binding.pry
    @name = data[:name]
    @description = data[:description]
    @unit_price =  data[:unit_price]
    @merchant_id = data[:merchant_id]
    @created_at  = data[:created_at]
    @updated_at = data[:updated_at]
  end
end
