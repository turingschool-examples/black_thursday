require './lib/sales_engine'
require 'pry'


class SalesAnalyst
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    the_merchants = @sales_engine.merchants.all
    average_array = []
    the_merchants.each do |merchant|
      average_array << total_matches(merchant.id)
    end
    sum = 0.0
    average_array.each do |average|
      sum += average
    end
    average = sum/average_array.count.to_f
    average
  end

  def total_matches(id)
    count = @sales_engine.items.find_all_by_merchant_id(id).count
    count
  end

end
