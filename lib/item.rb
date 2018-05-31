require 'bigdecimal'
require 'bigdecimal/util'
require 'pry'
require 'time'
class Item
  attr_accessor :name,
                :description,
                :unit_price,
                :updated_at
  attr_reader   :id,
                :created_at,
                :merchant_id

  def initialize(attributes)
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @description = attributes[:description]
    @unit_price = attributes[:unit_price].to_d / 100
    @created_at = Time.parse(attributes[:created_at])
    @updated_at = Time.parse(attributes[:updated_at])
    @merchant_id = attributes[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

end
