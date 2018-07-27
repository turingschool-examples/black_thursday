require "time"
require "bigdecimal"

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
    @name = hash[:name].to_s
    @description = hash[:description].to_s
    @unit_price = hash[:unit_price]
    @created_at = hash[:created_at]
    @updated_at = hash[:updated_at]
    @merchant_id = hash[:merchant_id].to_i
  end

end
