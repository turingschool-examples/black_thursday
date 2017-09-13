require 'csv'
require 'bigdecimal'
require 'bigdecimal/util'
require 'time'


class Item

  attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id

  def initialize(item)
    @id = item[:id]
    @name = item[:name]
    @description = item[:description]
    @unit_price = format_unit_price(item[:unit_price])
    @created_at = Time.parse(item[:created_at])
    @updated_at = Time.parse(item[:updated_at])
    @merchant_id = item[:merchant_id]
  end

  def format_unit_price(unit_price_in_cents)
    dollars = unit_price_in_cents.to_i / 100
    BigDecimal.new(dollars, 4)
  end

end
