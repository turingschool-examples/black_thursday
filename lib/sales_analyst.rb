require './mathable'
require './merchants_repository'
require './items_repository'
require 'pry'
require 'bigdecimal'

class Analyst
  include Mathable

  def initialize
    @mr = MerchantsRepository.new("./data/merchants.csv")
    @ir = ItemsRepository.new("./data/items.csv")
  end

  def average_items_per_merchant
    average(@ir.repository.count, @mr.repository.count)
  end

  def average_items_per_merchant_standard_deviation
    merchant_item_numbers = @ir.merchant_ids.values.map { |list| list.count }
    @stn_dev_ipm = standard_devation(merchant_item_numbers, average_items_per_merchant)
  end

  def merchants_with_high_item_count
    big_sellers = @ir.merchant_ids.select do |merchant, items|
      items.count > (average_items_per_merchant + average_items_per_merchant_standard_deviation)
    end
  end

  def average_item_price_per_merchant(merchant_id)
    items = @ir.find_all_by_merchant_id(merchant_id)
    unit_price_array = items.map { |price| price.unit_price.to_i}
    average_price = average(unit_price_array.sum, unit_price_array.count)
    in_dollars = BigDecimal((average_price / 100).round(2), 4)
    return in_dollars
  end

  def average_average_price_per_merchant
    array_of_prices = @mr.repository.map do |merchant|
      average_item_price_per_merchant(merchant.id)
    end
    return average(array_of_prices.sum, array_of_prices.count)
  end

  def golden_items
    list = @ir.repository.map { |item| item.unit_price.to_i}
    mean = average(list.sum, list.count)
    std_dev_aappm = standard_devation(list, mean)
    golden_items = @ir.repository.select do |gi|
      gi.unit_price.to_i > (mean + (std_dev_aappm * 2))
    end
    return golden_items
  end

end
