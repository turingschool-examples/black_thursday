require_relative "sales_engine"
require 'pry'
require_relative './merchant_math'
require_relative './merchant_golden_items'
require_relative './merchant_top_merchants_by_invoice_count'


class SalesAnalyst

  include MerchantMath
  include MerchantGoldenItems
  include MerchantTopMerchantsByInvoiceCount
  #we can move these all back into a single module if needed -- I was just getting confused and needed to be able to separate the different methods and helper methods

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def merchants_and_items
    make_merchants_and_things(sales_engine.items)
  end

  def merchants_and_invoices
    make_merchants_and_things(sales_engine.invoices)
  end

  def average_items_per_merchant
    merchants_and_items
    average_things_per_merchant(merchants_and_items)
  end

  def average_invoices_per_merchant
    merchants_and_invoices
    average_things_per_merchant(merchants_and_invoices)
  end

  def average_items_per_merchant_standard_deviation
    merchants_and_items
    average_things_per_merchant_standard_deviation(merchants_and_items)
  end

  def average_invoices_per_merchant_standard_deviation
    merchants_and_invoices
    average_things_per_merchant_standard_deviation(merchants_and_invoices)
  end

########

  def merchants_with_high_item_count
    merchant_ids = []
    one_above  = average_items_per_merchant + average_items_per_merchant_standard_deviation
    merchants_and_items.each do |key,value|
      merchant_ids << key.to_i if  value > one_above
    end
    merchants = []
    merchant_ids.each do |id|
      merchants << sales_engine.merchants.find_by_id(id)
    end
    merchants
  end

  def average_item_price_for_merchant_unrounded(merchant_id)
    total_items = sales_engine.items.find_all_by_merchant_id(merchant_id)
    item_prices = total_items.map do |item|
                    item.unit_price
                  end
    total_item_prices = item_prices.sum
    return 0.00 if total_items.length == 0
    total_item_prices / total_items.length
  end

  def average_item_price_for_merchant(merchant_id)
    average_item_price_for_merchant_unrounded(merchant_id).round(2)
  end

  def average_average_price_per_merchant
    average_price_array = sales_engine.merchants.all.map do |merchant|
                            average_item_price_for_merchant_unrounded(merchant.id)
                          end
    sum_averages = average_price_array.sum
    (sum_averages / sales_engine.merchants.all.count).floor(2)
  end

  def golden_items
    two_standard_deviations_above(sales_engine.items, sales_engine.merchants)
  end

  def top_merchants_by_invoice_count
    top_merchants = []
<<<<<<< HEAD
=======
    two_std_above = two_standard_deviations_above_merchant_invoices
>>>>>>> e3e5d4c924419e864ebe74e411864c2991ae0e51

    group_invoices_by_merchant.map do |key, value|
      if value >= two_std_above
        top_merchants << key
      end
    end

    top_merchants.map do |id|
      sales_engine.merchants.find_by_id(id)
    end
<<<<<<< HEAD
    puts "Yowza -- Top merchants by invoice!"
=======
>>>>>>> e3e5d4c924419e864ebe74e411864c2991ae0e51
  end

end
