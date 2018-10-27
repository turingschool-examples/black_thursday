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

  # def average_item_price_for_merchant(id)
  #   item_array = @items.find_all_by_merchant_id(id)
  #   prices = item_array.map do |item|
  #     item.unit_price_to_dollars
  #   end
  #   x = (prices.inject(:+)).round(2) / prices.count
  #   BigDecimal.new(x, x.to_s.length)
  # end


end
