require_relative 'sales_engine'
require_relative 'math'
require 'memoize'
require 'time'
require 'pry'

class SalesAnalyst
  include Math
  extend Memoize
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    total_items = sales_engine.items.items.count
    total_merchants = sales_engine.merchants.merchants.count
    (total_items.to_f / total_merchants.to_f).round(2)
  end

  def counts_per_merchant(method)
    sales_engine.merchants.merchants.map do |merchant|
      method.call(merchant.id).count
    end
  end

  def variance_of_items
    counts = counts_per_merchant(sales_engine.method(:find_merchant_items))
    counts.map do |count|
      result = (count - average_items_per_merchant)**2
      result.round(2)
    end
  end

  def sum_array
    variance_of_items.reduce(0) do |sum, number|
      sum + number
    end.round(2)
  end

  def average_items_per_merchant_standard_deviation
    result = sum_array / (sales_engine.merchants.merchants.count - 1)
    Math.sqrt(result).round(2)
  end
  memoize :average_items_per_merchant_standard_deviation


  def merchants_with_high_item_count
    counts = counts_per_merchant(sales_engine.method(:find_merchant_items))
    one_std_dev = mean(counts) + standard_deviation(counts)
    sales_engine.merchants.merchants.select do |merchant|
      sales_engine.find_merchant_items(merchant.id).count > one_std_dev
    end
  end
  memoize :merchants_with_high_item_count

  def average_item_price_for_merchant(merchant_id)
    merch_items = sales_engine.items.find_all_by_merchant_id(merchant_id)
    sum_price = merch_items.reduce(0) do |sum, item|
      sum += item.unit_price
    end
    roundy = sum_price / merch_items.count
    roundy.round(2)
  end

  def average_average_price_per_merchant
    prices = sales_engine.merchants.merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    mean(prices).round(2)
  end

  def average_item_price
    all = sales_engine.items.all
    avg_item = all.reduce(0) do |sum, item|
      sum += item.unit_price
    end
    avg_avg = avg_item / sales_engine.items.all.count
    avg_avg.round(2)
  end

  def item_unit_price_list
    sales_engine.items.items.map { |item| item.unit_price }
  end

  def std_dev_item_price
    standard_deviation(item_unit_price_list)
  end
  memoize :std_dev_item_price


  def golden_items
    std_deviation = std_dev_item_price
    sales_engine.items.items.select do |item|
      item.unit_price > (std_deviation * 2)
    end
  end
  memoize :golden_items

  def average_invoices_per_merchant
    total_invoices = sales_engine.invoices.invoices.count
    total_merchants = sales_engine.merchants.merchants.count
    (total_invoices.to_f / total_merchants.to_f).round(2)
  end
  memoize :average_invoices_per_merchant


  def average_invoices_per_merchant_standard_deviation
    counts = counts_per_merchant(sales_engine.method(:find_merchant_invoices))
    standard_deviation(counts)
  end
  memoize :average_invoices_per_merchant_standard_deviation

  def top_merchants_by_invoice_count
    counts = counts_per_merchant(sales_engine.method(:find_merchant_invoices))
    two_std_dev = mean(counts) + (standard_deviation(counts)*2)
    sales_engine.merchants.merchants.select do |merchant|
      sales_engine.find_merchant_invoices(merchant.id).count > two_std_dev
    end
  end
  memoize :top_merchants_by_invoice_count


  def bottom_merchants_by_invoice_count
    counts = counts_per_merchant(sales_engine.method(:find_merchant_invoices))
    two_std_dev = mean(counts) - (standard_deviation(counts)*2)
    sales_engine.merchants.merchants.select do |merchant|
      sales_engine.find_merchant_invoices(merchant.id).count < two_std_dev
    end
  end
  memoize :bottom_merchants_by_invoice_count

  def day_created
    sales_engine.invoices.all.map do |invoice|
      invoice.created_at.strftime("%A")
    end
  end
  memoize :day_created

  def day_count
    day_created.each_with_object(Hash.new(0)) {|day, invoices| invoices[day] +=1}
  end
  memoize :day_count

  def top_days_by_invoice_count
    std_dev = standard_deviation(day_count.values)
    mean_counts = mean(day_count.values)
    one_std_dev = std_dev + mean_counts
    day_count.select do |days, invoices|
      invoices > one_std_dev
    end.keys
  end
  memoize :top_days_by_invoice_count

  def invoice_status(status)
    all = sales_engine.invoices.all.count
    status_list = sales_engine.invoices.find_all_by_status(status).count
      (status_list.to_f / all * 100).round(2)
  end

  def total_revenue_by_date(date)
    time = date.to_s.split.first
    sales_engine.invoices.invoices.map do |invoice|
      if invoice.created_at.to_s.split.first == time
        sales_engine.total_invoice_amount(invoice.id)
      end
    end.compact.first.round(2)
  end

  def total_revenue_by_merchant(merchant_id)
    merchant_revenue = sales_engine.merchants.find_by_id(merchant_id).invoices
    merchant_revenue.reduce(0) do |sum, invoice|
      sum + invoice.total
    #figure out test
    end
  end

  def add_merchant_to_merchant_total
    merchant_totals = {}
    sales_engine.merchants.merchants.each do |merchant|
      merchant_totals[merchant] = total_revenue_by_merchant(merchant.id)
    end
    merchant_totals
    #figure out test
  end

  def merchants_ranked_by_revenue
    earners = add_merchant_to_merchant_total.sort_by {|merchant, total| total}
    earners.map do |pair|
      pair[0]
    end.reverse
  end

  def top_revenue_earners(x = 20)
    merchants_ranked_by_revenue.first(x)
  end

  def merchants_with_pending_invoices
    sales_engine.merchants.merchants.find_all do |merchant|
      merchant.invoices.any? {|invoice| invoice.total == 0}
    end
  end

end
