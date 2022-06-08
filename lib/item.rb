require_relative 'helper'
require_relative 'existable'
require_relative 'findable'

class Item
  include Existable
  include Findable

  attr_reader :id,
              :created_at,
              :merchant_id

  attr_accessor :name,
                :description,
                :updated_at,
                :unit_price

  def initialize(input)
    @id = input[:id].to_i
    @name = input[:name]
    @description = input[:description]
    @unit_price = input[:unit_price]
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
    @merchant_id = input[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
