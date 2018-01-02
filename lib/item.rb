require 'bigdecimal'

class Item

  attr_reader :id,
              :name,
              :description,
              :merchant_id,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(data)
    @id           = data[:id]
    @name         = data[:name]
    @description  = data[:description]
    @merchant_id  = data[:merchant_id]
    @unit_price   = data[:unit_price]
    @created_at   = data[:created_at]
    @updated_at   = data[:updated_at]
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

end
