require_relative "sales_engine"
require_relative './merchant_math'
require_relative './merchant_golden_items'
require_relative './merchant_merchants_by_invoice_count'
require_relative "./merchant_top_days_by_invoice_count"
require_relative "./merchant_top_revenue_earners"
require 'pry'
require "date"


class SalesAnalyst

  include MerchantMath
  include MerchantGoldenItems
  include MerchantMerchantsByInvoiceCount
  include MerchantTopDaysByInvoiceCount
  include MerchantTopRevenueEarners
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

  def invoice_status(status)
    decimal = invoices_with_status_count(status)/total_invoice_count
    (decimal * 100).round(2)
  end

  def total_invoice_count
    sales_engine.invoices.all.count.to_f
  end

  def invoices_with_status_count(status)
    sales_engine.invoices.find_all_by_status(status).count
  end

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
    two_std_above = two_standard_deviations_above_merchant_invoices
    group_invoices_by_merchant.map do |key, value|
      if value >= two_std_above
        top_merchants << key
        # puts "Yowza -- Top merchants by invoice!"
      end
    end
    top_merchants.map do |id|
      sales_engine.merchants.find_by_id(id)
    end
  end

  ##### Iteration 4 #####

  def merchants_with_pending_invoices
    merchants = sales_engine.merchants.all
    merchants.select do |merchant|
      merchant.has_pending_invoice?
    end
  end

  def merchants_with_only_one_item
    merchants = sales_engine.merchants.all
    only_one_item(merchants)
  end

  def only_one_item(merchants)
    merchants.select do |merchant|
      merchant.items.count == 1
    end
  end

  def bottom_merchants_by_invoice_count
    bottom_merchants = []
    two_std_below = two_standard_deviations_below_merchant_invoices
    group_invoices_by_merchant.map do |key, value|
      if value <= two_std_below
        bottom_merchants << key
        puts "Yowza -- Bottom merchants by invoice!"
      end
    end
    bottom_merchants.map do |id|
      sales_engine.merchants.find_by_id(id)
    end
  end

  def top_days_by_invoice_count
    find_top_days
    convert_numbers_to_weekdays
  end

  def  invoices_by_date(date)
    sales_engine.invoices.all.select do |invoice|
      invoice.created_at == date
    end
  end

  def total_revenue_by_date(date)
    invoices_by_date(date).map do |invoice|
      BigDecimal.new(invoice.total)
    end.sum.round(2)
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_for_month = sales_engine.merchants.merchants_registered_in_month(month)
    only_one_item(merchants_for_month)
  end

  def revenue_by_merchant(merchant_id)
    merchant_invoices = sales_engine.merchants.find_by_id(merchant_id).invoices
    merchant_invoices.map {|invoice| invoice.total}.sum
  end


  def most_sold_item_for_merchant(merchant_id)

    ###could try using this from the item repo:
    ###items.find_all_by_merchant_id(merchant_id) should return all items per merchant. Then find the item which occurs most in the array by using a hash?

    # merchant_id = 12336617
    # items_and_qty_hash = Hash.new(0)
    # all_items = sales_engine.items.find_all_by_merchant_id(merchant_id)
    # all_items.each do |item|
    #   items_and_qty_hash[item] += 1
    # end
    # puts items_and_qty_hash
    # array = items_and_qty_hash.max_by do |key, value|
    #   value
    #   #returns an array containing [key, value]
    # end
    # puts array
    #  #this should return the item_id


    #
    # #####################################
    # invoices = sales_engine.invoices.find_all_by_merchant_id(merchant_id)
    # ###collects all invoices for a merchant
    # invoice_items = invoices.map {|invoice| invoice.invoice_items}.flatten
    # ###get an array of each item on each invoice, and flatten.
    #
    # # binding.pry
    # invoice_item_quantities = invoice_items.map do |invoice_item|
    #                             {invoice_item.item_id => invoice_item.quantity}
    #                           end
    # ###creates a hash of item_id => qty
    #
    # item_quantities =
    #   invoice_item_quantities.reduce do |item_quantity, invoice_item|
    #     item_quantity.merge(invoice_item) {|key, oldval, newval| newval + oldval}
    #   end
    # ###trying to merge the values so there is 1 key per value
    #
    # # binding.pry
    # item_id_quantities = item_quantities.each_value {|quantity| quantity}.max
    # ### of the values, find the max value
    #
    # # binding.pry
    # item_ids = item_id_quantities.select.with_index {|id, i| i.even?}
    # # binding.pry
    # item_ids.map do |item_id|
    #   sales_engine.items.find_by_id(item_id)
    # end
  end

  def merchants_ranked_by_revenue
    puts "sa 236"
    top_revenue_by_id = single_merchant_id_with_total_revenue.map do |key, value|
      key
      puts "sa 239"
    end

    top_merchants = []
    top_revenue_by_id.each do |id|
      top_merchants << sales_engine.merchants.find_by_id(id)
      puts "sa 245"
    end
    top_merchants
  end

  def top_revenue_earners(number = 20)
  #  binding.pry
  puts "sa 252"
    range = (number-1)
    merchants_ranked_by_revenue[0..range]
    puts merchants_ranked_by_revenue[0..range]  #this works
  end

end
