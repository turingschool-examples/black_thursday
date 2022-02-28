require 'csv'
require './lib/items_repository'
require './lib/merchants_repository'
require './lib/invoice_items_repository'
require './lib/invoice_repository'
require './lib/customer_repository'
require './lib/transaction_repository'

class Analyst

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
    @mean_per_merchant = average(@items_per_merchant_count)
  end

  def average_items_per_merchant_standard_deviation
    standard_devation(@items_per_merchant_count, @mean_per_merchant)
  end

  def merchants_with_high_item_count
    #find merchants with more than one standard_devation higher than average
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
