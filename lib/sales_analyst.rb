require_relative "sales_engine"
require_relative "sales_analyst_math"
require_relative "sales_analyst_golden_items"
require_relative "sales_analyst_merchants_by_invoice_count"
require_relative "sales_analyst_top_days_by_invoice_count"
require_relative "sales_analyst_top_revenue_earners"
require_relative "sales_analyst_best_item_for_merchant"
require_relative "finder"
require "date"
require 'pry'




class SalesAnalyst

  include Finder
  include MerchantMath
  include MerchantGoldenItems
  include MerchantMerchantsByInvoiceCount
  include MerchantTopDaysByInvoiceCount
  include MerchantTopRevenueEarners
  include BestItemForMerchant

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

  def invoice_status(status)
    decimal = invoices_with_status_count(status)/total_invoice_count
    (decimal * 100).round(2)
  end

  def total_invoice_count
    invoices.count.to_f
  end

  def invoices_with_status_count(status)
    invoice_repo.find_all_by_status(status).count
  end

  def merchants_with_high_item_count
    merchant_ids = []
    one_above  = average_items_per_merchant + average_items_per_merchant_standard_deviation
    merchants_and_items.each do |key,value|
      merchant_ids << key.to_i if  value > one_above
    end
    merchants = []
    merchant_ids.each do |id|
      merchants << merchant_repo.find_by_id(id)
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
    average_price_array = merchants.map do |merchant|
                            average_item_price_for_merchant_unrounded(merchant.id)
                          end
    sum_averages = average_price_array.sum
    (sum_averages / merchants.count).floor(2)
  end

  def golden_items
    two_standard_deviations_above(item_repo, merchant_repo)
  end

  def top_merchants_by_invoice_count
    top_merchants = []
    two_std_above = two_standard_deviations_above_merchant_invoices
    group_invoices_by_merchant.map do |key, value|
      if value >= two_std_above
        top_merchants << key
      end
    end
    top_merchants.map { |id| sales_engine.merchants.find_by_id(id) }
  end

  def merchants_with_pending_invoices
    merchants.select { |merchant| merchant.has_pending_invoice? }
  end

  def merchants_with_only_one_item
    only_one_item(merchants)
  end

  def only_one_item(merchants)
    merchants.select { |merchant| merchant.items.count == 1 }
  end

  def bottom_merchants_by_invoice_count
    bottom_merchants = []
    two_std_below = two_standard_deviations_below_merchant_invoices
    group_invoices_by_merchant.map do |key, value|
      if value <= two_std_below
        bottom_merchants << key
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
    invoices.select do |invoice|
      invoice.created_at == date
    end
  end

  def total_revenue_by_date(date)
    invoices_by_date(date).map do |invoice|
      BigDecimal.new(invoice.total)
    end.sum.round(2)
  end

  def merchants_with_only_one_item_registered_in_month(month)
    only_one_item(merchants_for_month(month))
  end

  def revenue_by_merchant(merchant_id)
    merchant_invoices(merchant_id).map {|invoice| invoice.total}.sum
  end

  def merchants_ranked_by_revenue
    top_revenue_by_id = single_merchant_id_with_total_revenue.map { |key, value| key }
    top_merchants = []
    top_revenue_by_id.each do |id|
      top_merchants << sales_engine.merchants.find_by_id(id)
    end
    top_merchants
  end

  def top_revenue_earners(number = 20)
    range = (number-1)
    merchants_ranked_by_revenue[0..range]
  end

  ######

  def most_sold_item_for_merchant(merchant_id)
    largest_quantity_item_ids(merchant_id).map do |item_id|
      sales_engine.items.find_by_id(item_id)
    end
  end

  def merchant_invoices(merchant_id)
    merchant = sales_engine.merchants.find_by_id(merchant_id)
    merchant.invoices
  end

  def merchant_invoices_paid_in_full(merchant_id)
    merchant_invoices(merchant_id).select do |invoice|
      invoice.is_paid_in_full?
    end
  end

  def invoices_to_invoice_items(merchant_id)
    merchant_invoices_paid_in_full(merchant_id).map do |invoice|
      invoice.invoice_items
    end.flatten
  end

  def item_quantities(merchant_id)
    item_quantity = {}
    invoices_to_invoice_items(merchant_id).map do |invoice_item|
      i_q = {invoice_item.item_id => invoice_item.quantity}
      item_quantity.merge!(i_q){|key, oldval, newval| newval + oldval}
    end
    item_quantity
  end

  def largest_quantity(merchant_id)
    item_quantities(merchant_id).values.max
  end

  def largest_quantity_item_ids(merchant_id)
    largest_quantity = largest_quantity(merchant_id)
    item_quantities(merchant_id).select do |key,value|
      value == largest_quantity
    end.keys
  end

  def best_item_for_merchant(merchant_id)
    id = highest_value_item(merchant_id)
    sales_engine.items.find_by_id(id)
  end

end
