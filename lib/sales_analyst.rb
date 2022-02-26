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

  def get_merchants
    merchant_ids = @mr.repository.map do |merchant|
      merchant.id
    end.uniq
  end

  def get_array_of_merchant_items
    array_of_merchant_items = merchant_ids.map do |id|
      @ir.find_all_by_merchant_id(id)
    end
  end

  def get_array_of_items_per_merchant_count
    @items_per_merchant_count = array_of_merchant_items.map do |array|
      array.count
    end
  end

  def average_items_per_merchant
    average(@ir.repository.count, @mr.repository.count)
  end

  def average_items_per_merchant_standard_deviation
    merchant_item_numbers = @ir.merchant_ids.values.map { |list| list.count }
    @stn_dev_ipm = standard_devation(merchant_item_numbers, average_items_per_merchant)
  end

  def merchants_with_high_item_count
    # @items_per_merchant_count.find_all { |}
    #find merchants with more items than one standard_devation higher than average
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
