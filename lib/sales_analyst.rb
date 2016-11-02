require 'pry'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    binding.pry
    @sales_engine.merchants.all.count
    # take in number of items for each merchant
    # return average items per merchant as a FLOAT
    average(array)
  end

  def average(array)
    array.inject{ |sum, element| sum + element }.to_f / array.count
  end

  def average_items_per_merchant_standard_deviation
    # take in number of items for each merchant
    # take in average items for each merchant
    # return standard deviation as a FLOAT
  end

  def merchants_with_high_item_count
    # take in standard deviation
    # take in average number of items
    # return merchants with more than one standard deviation
    # above average number of items as an ARRAY
  end

  def average_item_price_for_merchant(id)
    # take in merchant id
    # take in list of merchant's items' prices
    # return average of those prices as a BIGDECIMAL
    average_price = average(prices)
    return BigDecimal.new(average_price, 4)
  end

  def average_average_price_per_merchant
    # average accross all merchant's average prices
    # return BIGDECIMAL
    average_price = average(prices)
    return BigDecimal.new(average_price, 4)
  end

  def golden_items
    # take in standard deviation, average price
    # search for items that are 2 standard deviations above
    # average and return ARRAY of those item objects
  end
end
