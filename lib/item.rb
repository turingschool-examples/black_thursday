require 'bigdecimal'
require_relative 'business_data'

class Item < BusinessData
  attr_reader :id, :created_at, :merchant_id
  attr_accessor :name, :description, :unit_price, :updated_at

  def initialize(input_hash)
    @id = input_hash[:id]
    @name = input_hash[:name]
    @description = input_hash[:description]
    @unit_price = input_hash[:unit_price]
    @created_at = input_hash[:created_at]
    @updated_at = input_hash[:updated_at]
    @merchant_id = input_hash[:merchant_id]
  end

  def unit_price_to_dollars
    unit_price.to_f.round(2)
  end
end
