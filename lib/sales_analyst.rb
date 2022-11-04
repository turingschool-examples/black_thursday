require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    item_count = sales_engine.items.all.count.to_f
    merchant_count = sales_engine.merchants.all.count.to_f
    (item_count / merchant_count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    merchants = sales_engine.merchants.all
    avg = average_items_per_merchant
    total_difference = merchants.inject(0) do |sum, merchant|
      merchant_items = sales_engine.items.find_all_by_merchant_id(merchant.id)
      #   Take the difference between each number and the mean, then square it.
      sum += (merchant_items.count - avg)**2
      #   ^Sum these square differences together.
    end
    Math.sqrt(total_difference / (merchants.length - 1)).round(2)
    # Divide the sum by the number of elements minus 1.
    # Take the square root of this result.
  end

  def merchants_with_high_item_count
    # merchants with 5 or more items
    require 'pry'; binding.pry
  end
end
