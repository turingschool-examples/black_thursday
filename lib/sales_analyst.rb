require_relative '../lib/sales_engine'
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

  def all_merchant_item_count
    @merchants.all.map do |merchant|
      x = merchant.id
      y = items.find_all_by_merchant_id(x)
      y.count
    end
  end

  def merchant_count_minus_average
    avg = average_items_per_merchant
    all_merchant_item_count.map do |num|
      num - avg
    end
  end

  def sum_squares
    squares = merchant_count_minus_average.map do |num|
      num * num
    end
    # require 'pry'
    # binding.pry
    final = 0
    squares.each do |square|
      final += square.round(3)
    end
    final
  end

  def average_items_per_merchant_standard_deviation
    counts = []
    avg = average_items_per_merchant
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
    high_merchants = []
    @merchants.all.map do |merchant|
      x = merchant.id
      y = items.find_all_by_merchant_id(x)
      if y.count >= 7
        high_merchants << @merchants.find_by_id(x)
      end
    end
    high_merchants
  end

end
