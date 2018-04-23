require 'pry'
require 'bigdecimal'
class Item

  attr_reader   :id,
                :merchant_id,
                :parent,
                :downcased_description,
                :unit_price_to_dollars
  attr_accessor :created_at,
                :updated_at,
                :name,
                :description,
                :unit_price

  def initialize(data, parent)
    @id = data[:id].to_i
    @name = data[:name]
    @description = data[:description]
    @downcased_description = description.downcase
    @unit_price = BigDecimal.new(data[:unit_price])/100
    @unit_price_to_dollars = unit_price.to_f
    @merchant_id = data[:merchant_id].to_i
    @created_at = Time.parse(data[:created_at].to_s)
    @updated_at = Time.parse(data[:updated_at].to_s)
    @parent = parent
  end
end