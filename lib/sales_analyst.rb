require './lib/sales_engine'
require './lib/calculator'
require 'pry'
class SalesAnalyst
  include Calculator

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    average(all_averages)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviance(all_averages)
  end

  def merchants_with_high_item_count
    s_dev    = average_items_per_merchant_standard_deviation
    avg_each = average_items_per_merchant
    mark = s_dev + avg_each
    example_merch = []
    example_merch = all_averages.find_all do |average|
      if average[:count] > mark
        example_merch << average[:merchant]
      end
    end
    example_merch
  end


  def all_averages
    the_merchants = @sales_engine.merchants.all
    average_set = []
    the_merchants.each do |merchant|
      average_set << {count: total_matches(merchant.id), merchant: merchant}
    end
    average_set
  end

  def average(data_set)
    sum = 0
    data_set.each do |average|
      sum += average[:count]
    end
    average = (sum/data_set.count.to_f)
    average.round(2)
  end

  def total_matches(id)
    count = @sales_engine.items.find_all_by_merchant_id(id).count
    count
  end

end
