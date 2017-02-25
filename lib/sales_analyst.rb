require 'pry'

class SalesAnalyst
  attr_reader :sales_engine_instance

  def initialize(sales_engine_instance)
    @sales_engine_instance = sales_engine_instance
  end

  def average_items_per_merchant
	(sales_engine_instance.items.all.count.to_f / sales_engine_instance.merchants.all.count.to_f).round(2)
  end

  def difference_between_mean_and_item_count_squared_summed
    mean = average_items_per_merchant
    get_merchant_items_set.map do |item_count|
      (item_count - mean) ** 2
    end.reduce(:+)
  end

  def get_merchant_items_set
    sales_engine_instance.merchants.all.map do |merchant|
      merchant.items.count
    end
  end
  
  def average_items_per_merchant_standard_deviation
    set_length = (get_merchant_items_set.length - 1)
    Math.sqrt(difference_between_mean_and_item_count_squared_summed/set_length).round(2)
  end
end
