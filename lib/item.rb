require 'bigdecimal'

class Item
    attr_reader   :id,
                  :merchant_id,
                  :created_at
    attr_accessor :name,
                  :description,
                  :unit_price,
                  :updated_at

  def initialize(information)
    @id = information[:id]
    @name = information[:name]
    @description = information[:description]
    @unit_price = information[:unit_price]
    @merchant_id = information[:merchant_id]
    @created_at = information[:created_at]
    @updated_at = information[:updated_at]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
