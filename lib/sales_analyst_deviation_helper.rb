require_relative '../lib/sales_engine'
module SalesAnalystHelper

  def mean_method
    average_items_per_merchant
  end

  def standard_dev(data, mean)
    total_sum = data.inject(0) do |sum, number_items|
      sum + (number_items - mean)**2
    end
    Math.sqrt(total_sum / (data.size - 1)).round(2).to_f
  end

  def all_items
    @sales_engine.items.all
  end

  def all_merchants
    @sales_engine.merchants.all
  end



end
