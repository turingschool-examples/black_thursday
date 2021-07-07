require 'bigdecimal'
require 'time'
require_relative '../modules/traversal'

# This is the item class
class Item
  include Traversal
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :parent

  def initialize(data, parent)
    @id = data[:id].to_i
    @name = data[:name]
    @description = data[:description]
    @unit_price = BigDecimal.new(data[:unit_price].to_i) / 100
    @merchant_id = data[:merchant_id].to_i
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @parent = parent
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def merchant
    traverse('find_merchant', merchant_id)
  end
end
