require_relative 'sales_engine'
require_relative 'standard_deviation'

class SalesAnalyst
  include StandardDeviation

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine    
  end

  def average_items_per_merchant_standard_deviation
    sample_set = []
      merchants_and_items = sales_engine.merchants.all.map do |merchant|
        sample_set << sales_engine.find_all_items_by_merchant_id(merchant.id).count
      end
    standard_deviation(sample_set).round(2)
  end

  def average_items_per_merchant
    @item_counts = sales_engine.merchants.all.map { |merchant| merchant.items.size }
    average(@item_counts)
  end

  def average_item_price_for_merchant(id)
    all_prices = sales_engine.merchants.find_all_items_by_merchant(id).map do |item|
      item.unit_price.to_f
    end
    average(all_prices)
  end

  def average_average_price_per_merchant
    averages = sales_engine.merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    average(averages)
  end

  def average(collection)
    collection.reduce(&:+) / collection.size
  end

  def merchants_with_high_item_count
    names = sales_engine.merchants.all.map { |merchant| merchant.name }
    @item_counts.sort!.reverse!
    @item_counts.zip(names)[0..2]
  end

  def golden_items
  end
  
end
