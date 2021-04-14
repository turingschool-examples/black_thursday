require './lib/sales_engine'
require 'bigdecimal'

class SalesAnalyst
  attr_reader :merchants,
              :items

  def initialize(merchants, items)
    @merchants = merchants
    @items = items
  end

  def average_items_per_merchant
    @items.all.length.fdiv(@merchants.all.length).round(2)
  end

  # Brant's magic method
  def average_items_per_merchant_standard_deviation
    merchant_ids = @merchants.all.map do |merchant|
      merchant.id
    end
    items_per_merchant = merchant_ids.map do |id|
      @items.find_all_by_merchant_id(id).length
    end
    sum_of_squares = items_per_merchant.map do |wares|
      (wares - average_items_per_merchant) **2
    end.sum
    (sum_of_squares.fdiv(merchant_ids.length - 1) **0.5).round(2)
  end

  def merchants_with_high_item_count
    one_standard = average_items_per_merchant + average_items_per_merchant_standard_deviation
    merchant_ids = @merchants.all.map do |merchant|
      merchant.id
    end
    merchant_ids_high_count = merchant_ids.find_all do |id|
      number_of_items = @items.find_all_by_merchant_id(id).length
      number_of_items > one_standard
    end
    @merchants.all.find_all do |merchant|
      merchant_ids_high_count.include?(merchant.id)
    end
  end

  def average_item_price_for_merchant(id)
    items_by_merchant_array = @items.find_all_by_merchant_id(id)
    test = items_by_merchant_array.sum do |item|
      item.unit_price.to_f
    end.fdiv(items_by_merchant_array.length)
    test.round(2)
  end

  def average_average_price_per_merchant
    @merchants.all.sum do |merchant|
      average_item_price_for_merchant(merchant.id)
    end.fdiv(@merchants.all.length).round(2)
  end

  def average_item_price
    @items.all.sum do |item|
      item.unit_price.to_f
    end.fdiv(@items.all.length).round(2)
  end

  def item_price_standard_deviation
    item_average = average_item_price
    denominator = @items.all.sum do |item|
      (item.unit_price.to_f - item_average) **2
    end
    (denominator.fdiv((@items.all.length) -1) **0.5).round(2)
  end

  def golden_items
    two_standard = average_item_price + item_price_standard_deviation * 2
    @items.all.find_all do |item|
      item.unit_price.to_f > two_standard
    end
  end
end
