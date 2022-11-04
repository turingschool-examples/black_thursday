require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    (sales_engine.items.all.count / sales_engine.merchants.all.count.to_f).round(2)
    # find_all_by_merchant_id(merchant_id)
    # require 'pry'; binding.pry
    # test = sales_engine.items.all.map do |item|
    #     sales_engine.items.find_all_by_merchant_id(item.merchant_id).length
    # end
    # require 'pry'; binding.pry
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
end
