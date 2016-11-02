require_relative 'find_functions'
require "pry"


class SalesAnalyst
  include FindFunctions
  attr_reader :merchants,
              :items,
              :all

  def initialize(sales_engine)
    @merchants = sales_engine.merchants
    @items     = sales_engine.items
    @all       = sales_engine
  end

  def average_items_per_merchant
    (items.all.count / merchants.all.count.to_f).round(2)
  end





  def average_item_price_per_merchant(input)
    merchants = items.all.find_all {|row| row.merchant_id == input }
    (merchants.map {|row|  row.unit_price}).reduce(:+)
  end

end
