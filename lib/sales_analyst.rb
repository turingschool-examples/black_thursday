require 'pry'
require_relative 'sales_engine'
class SalesAnalyst
  def initialize(se)
    @se = se
    @mr = @se.merchants
    @ir = @se.items
  end

  def average_items_per_merchant
    #can ask item repo for items.count and merch repo merchants.count
    merchant_ids = @mr.all.map { |merchant| merchant.id }
    total_items = merchant_ids.reduce(0) do |sum, id|
      sum += @mr.find_items(id).count
    end
    (total_items/@mr.merchants.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    merchant_ids = @mr.all.map { |merchant| merchant.id }
    item_count = merchant_ids.map do |id|
      @mr.find_items(id).count
    end

    sum = item_count.reduce(0) do |sum, count|
      sum + ((count - average) ** 2).to_f
    end
    deviation = Math.sqrt(sum / @mr.all.count - 1).round(2)
    # (deviation * 100).floor / 100.0
  end

  def merchants_with_high_item_count
    threshold = average_items_per_merchant + average_items_per_merchant_standard_deviation + 1
    merchant_ids = @mr.all.map { |merchant| merchant.id }
    golden_merchants = []
    merchant_ids.each do |id|
      item_count = @mr.find_items(id).count
      if item_count >= threshold
        golden_merchants << @mr.find_by_id(id)
      end
    end
    golden_merchants
  end

  def average_item_price_for_merchant(id)
    items = @mr.find_items(id)
    prices = items.map do |item|
      item.unit_price
    end
    (prices.reduce(:+)/items.count).round(2)
  end

  def average_average_price_per_merchant
    merchants_ids = @mr.all.map { |merchant| merchant.id }
    prices = merchants_ids.reduce(0) do |sum, id|
      sum += average_item_price_for_merchant(id)
    end
    (prices / merchants_ids.count).round(2)
  end

  def golden_items
    p_deviation = (price_deviation * 2) + average_average_price_per_merchant
    @ir.all.find_all do |item|
      item.unit_price >= p_deviation
    end
  end

  def find_all_item_prices
    merchant_ids = @mr.all.map { |merchant| merchant.id }
    item_prices = merchant_ids.map do |id|
      prices = @mr.find_items(id).map do |item|
        item.unit_price
      end
    end
    item_prices.flatten
  end

  def price_deviation
    sum = find_all_item_prices.reduce(0) do |sum, price|
      sum + ((price - average_average_price_per_merchant) ** 2)
    end
    deviation = Math.sqrt(sum / (@ir.all.count - 1)).round(2)
    # (deviation * 100).floor / 100.0
  end
end
