require 'bigdecimal'
require 'pry'
require_relative 'sales_engine'

class SalesAnalyst

  attr_reader :se,
              :average_item_prices

  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    (se.grab_total_amount_of_items / se.grab_total_amount_of_merchants.to_f).round(2)
  end

  def number_of_items_per_merchant
    se.grab_array_of_merchant_items
  end

  def average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant
    variance = number_of_items_per_merchant.reduce(0) do |var, items|
      var + (items - mean) ** 2
    end
    (Math.sqrt(variance/(se.grab_all_merchants.count - 1))).round(2)
  end

  def item_prices_mean
    items = se.grab_all_items
    item_prices = items.reduce(0) { |result, item| result += item.unit_price.to_i}
    (item_prices / items.count).round(2)
  end

  def item_price_standard_deviation # NEEDS TEST
    items = se.grab_all_items
    price_variance = items.reduce(0) do |result, item|
      result += (item.unit_price.to_i - item_prices_mean) ** 2
    end
    (Math.sqrt(price_variance/(items.count - 1))).round(2)
  end

  def merchants_with_high_item_count
    merchants = se.grab_all_merchants
    merchants.find_all do |merchant|
      item_count = number_of_items_per_merchant.sum
      binding.pry
      merchant if item_count > average_items_per_merchant_standard_deviation
    end
    # se.grab_merchants_with_high_items(self)
  end

  def average_item_price_for_merchant(merchant_id)
    merchant           = se.find_merchant_by_id(merchant_id)
    items              = se.find_item_by_merchant_id(merchant_id)
    summed_item_prices = items.reduce(0) { |res, item| res += item.unit_price}
    (summed_item_prices / items.count).round(2)
  end

  def average_average_price_per_merchant
    merchants = se.grab_all_merchants
    price = merchants.map {|merch| average_item_price_for_merchant(merch.id)}.sum
    (price / merchants.count).round(2)
  end

  def golden_items
    items = se.grab_all_items
    items.find_all do |item|
      price = item.unit_price
      if price > (item_price_standard_deviation * 2)
        item
      end
    end
  end

end
