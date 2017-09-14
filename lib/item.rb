require_relative 'item_repository'
require 'bigdecimal'
require 'time'

class Item

  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,
              :item_repository

  def initialize(ir, csv_info)
    @id = csv_info[:id]
    @name = csv_info[:name]
    @description = csv_info[:description]
    @unit_price = unit_price_to_dollars(csv_info[:unit_price])
    @created_at = Time.parse(csv_info[:created_at].to_s)
    @updated_at = Time.parse(csv_info[:updated_at].to_s)
    @merchant_id = csv_info[:merchant_id]
    @item_repository = ir
  end

  def unit_price_to_dollars(unit_price)
    dollars = unit_price.to_f / 100
    BigDecimal.new(dollars, 4)
  end

end
