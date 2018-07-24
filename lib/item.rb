require 'time'
require 'bigdecimal'

class Item

  attr_reader     :id,
                  :created_at,
                  :merchant_id

  attr_accessor   :name,
                  :description,
                  :unit_price,
                  :updated_at

  def initialize(info)
    @id = info[:id].to_i
    @name = info[:name]
    @description = info[:description]
    @unit_price = BigDecimal(info[:unit_price]) / 100
    @created_at = Time.parse(info[:created_at].to_s)
    @updated_at = Time.parse(info[:updated_at].to_s)
    @merchant_id = info[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
