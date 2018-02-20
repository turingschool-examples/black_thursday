require 'bigdecimal'
require 'pry'

class SalesAnalyst
  attr_reader :sales_engine
  def initialize(se)
    @sales_engine = se
  end

  def average_items_per_merchant
    @total = 0
    @sales_engine.merchants.all.map do |merchant|
     @total += merchant.items.length
    end
    (((@total.to_f / @sales_engine.merchants.all.length.to_f) * 100).round)/100.0
  end

  def average_items_per_merchant_standard_deviation
    lengths = @sales_engine.merchants.all.map do |merchant|
      merchant.items.length
    end
    squares = lengths.map do |num|
      (num - average_items_per_merchant) ** 2
    end
    chaos = (squares.sum) / (@sales_engine.merchants.all.length - 1)
    # binding.pry
    Math.sqrt(chaos)
  end
end
