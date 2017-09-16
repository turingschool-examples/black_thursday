require 'csv'
require 'bigdecimal'
require 'bigdecimal/util'
require 'time'


class Item

  attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id

  def initialize(item_info, engine)
    @id = item_info[:id].to_i
    @name = item_info[:name]
    @description = item_info[:description]
    @unit_price = format_unit_price(item_info[:unit_price])
    @created_at = Time.parse(item_info[:created_at])
    @updated_at = Time.parse(item_info[:updated_at])
    @merchant_id = item_info[:merchant_id].to_i
    @engine = engine
  end

  def format_unit_price(unit_price_in_cents)
    dollars = unit_price_in_cents.to_f / 100
    BigDecimal.new(dollars, 4)
  end

  def merchant
    @engine.merchants.find_by_id(@merchant_id)
  end

  # def inspect
  #   "#<#{self.class} #{@merchants.size} rows>"
  # end


end
