require_relative '../lib/sales_engine'
require 'bigdecimal'
require 'mathn'
class SalesAnalyst
  attr_reader     :items, :merchants
  def initialize(items, merchants)
    @items      = items
    @merchants  = merchants
  end

  def count_all_items
    @items.all.count.round(2)
  end

  def count_all_merchants
    @merchants.all.count.round(2)
  end

  def average_items_per_merchant
    (count_all_items / count_all_merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    avg = average_items_per_merchant
    counts = []
    @merchants.all.map do |merchant|
      x = merchant.id
      y = items.find_all_by_merchant_id(x)
      counts << (y.count - avg).to_f
    end
    sum = 0.00
    squares = counts.map do |num|
      num * num
    end
    squares.each do |square|
      sum += square
    end
    (Math.sqrt(sum / (count_all_merchants - 1))).round(2)
  end

  def merchants_with_high_item_count
    count = []
    @merchants.all.map do |merchant|
      x = merchant.id
      y = items.find_all_by_merchant_id(x)
      if y.count >= 7
        count << @merchants.find_by_id(x)
      end
    end
    count
  end

  def average_item_price_for_merchant(id)
    item_array = @items.find_all_by_merchant_id(id)
    prices = item_array.map do |item|
      item.unit_price_to_dollars
    end
    accumulator = 0
    prices.each do |price|
      accumulator += price
    end
    number = (accumulator / prices.length).round(2)
    significant_digits = number.to_s.length
    BigDecimal.new(number, significant_digits)
  end

  def average_average_price_per_merchant
    price_array = @merchants.all.map do |merchant|
      x = merchant.id
      average_item_price_for_merchant(x)
    end
    accumulator = 0
    price_array.each do |price|
      accumulator += price
    end
    (accumulator / (price_array.length)).round(2)
  end

  def price_average
    avg_items = 0
      avg = @items.all.map do |item|
          avg_items += item.unit_price_to_dollars
      end
      avg_items / avg.length
  end

  def price_standard_deviation
    average = price_average
    diff_array = @items.all.map do |item|
      difference = item.unit_price_to_dollars - average
      difference * difference
    end
    accumulator = 0
    diff_array.each do |diff|
    accumulator += diff
    end
    (Math.sqrt(accumulator / diff_array.length)).round(2)
  end

  def golden_items
    standard_dev = price_standard_deviation
    average_price = price_average
    golden_items_array = @items.all.find_all do |item|
      (item.unit_price_to_dollars - average_price) > (standard_dev * 2)
    end
  end
end
