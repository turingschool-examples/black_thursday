require './mathable'
require './merchants_repository'
require './items_repository'
require 'pry'

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
      items.count > average_items_per_merchant_standard_deviation
    end
    big_sellers.keys
    #find merchants with items than one standard_devation higher than average
  end

  def average_item_price_per_merchant(merchant_id)
    #find the average price of items sold by merchant
  end

  def average_average_price_per_merchant
    #add all the average price together and find average
  end

  def golden_items
    #find the average price of items(of all items)
    #find the standard_devation of the price of items
    #find items more than two standard_devation away higher than average item price
  end

end
