require 'pry'
require_relative 'sales_engine'
class SalesAnalyst
  def initialize(se)
    @se = se
    @mr = @se.merchants
  end

  def average_items_per_merchant
    #can ask item repo for items.count and merch repo merchants.count
    merchant_ids = @mr.all.map { |merchant| merchant.id }
    total_items = merchant_ids.reduce(0) do |sum, id|
      sum += @mr.find_items(id).count
    end
    total_items/@mr.merchants.count.to_f
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    merchant_ids = @mr.all.map { |merchant| merchant.id }
    item_count = merchant_ids.map do |id|
      @mr.find_items(id).count
    end

    sum = item_count.reduce(0) do |sum, count|
      (count - average) ** 2
    end
    deviation = Math.sqrt(sum / 2)
    (deviation * 100).floor / 100.0
  end

  def merchants_with_high_item_count
    merchant_ids = @mr.all.map { |merchant| merchant.id }
    golden_merchants = []
    merchant_ids.each do |id|
      item_count = @mr.find_items(id).count
      if item_count >= average_items_per_merchant_standard_deviation + 1
        golden_merchants << @mr.find_by_id(id)
      end
    end
    golden_merchants
  end

  def average_item_price_for_merchant(id)
    #get items of one merchant by id
    #find price of each and average
    items = @mr.find_items(id)
    prices = items.map do |item|
      item.unit_price
    end
    prices.reduce(:+)/items.count
  end

  def average_average_price_per_merchant
    merchants_ids = @mr.all.map { |merchant| merchant.id }
    prices = merchants_ids.reduce(0) do |sum, id|
      sum += average_item_price_for_merchant(id)
    end
    prices / merchants_ids.count
  end
  def golden_items
    price_deviation
  end
  def price_deviation
    average = average_average_price_per_merchant
    merchant_ids = @mr.all.map { |merchant| merchant.id }
    item_prices = merchant_ids.map do |id|
      prices = @mr.find_items(id).map do |item|
        item.unit_price
      end
    end

    sum = item_prices.flatten.reduce(0) do |sum, price|
      (price - average) ** 2
    end
    deviation = Math.sqrt(sum / 2)
    (deviation * 100).floor / 100.0
  end
end
