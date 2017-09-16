require 'pry'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    total_items = sales_engine.items.items.count
    total_merchants = sales_engine.merchants.merchants.count
    (total_items.to_f / total_merchants).round(2)
  end

  def find_averages
    sales_engine.merchants.merchants.map do |merchant|
      items_for_merchant = sales_engine.find_merchant_items(merchant.id)
        if items_for_merchant.count <= 1
          1
        else
          items_for_merchant.count.round(2)
        end
    end
  end

  def average_items_per_merchant_standard_deviation
    avg_avgs = find_averages.sum / find_averages.count
    differences_squared = find_averages.map do |num|
      (num - avg_avgs)**2
    end
    Math.sqrt(differences_squared.sum / (differences_squared.count - 1)).round(2)
  end
end
