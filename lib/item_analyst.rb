require_relative 'item_repository'
require_relative 'math_helper'

class ItemAnalyst
  include MathHelper
  def initialize(item_repository)
    @item_repo = item_repository
  end

  def group_item_by_merchant_id
    @item_repo.all.group_by { |item| item.merchant_id }
  end

  def number_of_merchants
    group_item_by_merchant_id.keys.count
  end

  def average_items_per_merchant
    (@item_repo.all.size / number_of_merchants.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    mean_total_sqr = group_item_by_merchant_id
    mean_items_per = average_items_per_merchant
    final_square(mean_total_sqr, mean_items_per)
  end

  def get_squared_item_prices
    @item_repo.items.map do |item|
      (item.unit_price - @item_repo.mean_item_price) ** 2
    end
  end

  def get_mean_of_items_squared
    sum = get_squared_item_prices.inject(0) do |total, price|
      total += price
    end
    sum / get_squared_item_prices.count
  end

   def average_price_per_item_standard_deviation
    (Math.sqrt( get_mean_of_items_squared )).round(2)
  end

    def golden_items
    mean  = @item_repo.mean_item_price
    stdev = average_price_per_item_standard_deviation * 2
    @item_repo.items.find_all do |item|
      item.unit_price > (mean + stdev)
    end
  end


end
