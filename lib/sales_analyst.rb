require_relative 'sales_engine'
require_relative 'standard_deviation'
require 'pry'

class SalesAnalyst
  include StandardDeviation
  attr_reader   :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def total_items
    sales_engine.items.all.count
  end

  def total_merchants
    sales_engine.merchants.all.count
  end

  def total_invoices
    sales_engine.invoices.all.count
  end

  def average_items_per_merchant
    (total_items.to_f / total_merchants.to_f).round(2)
  end

  def average_invoices_per_merchant
    (total_invoices.to_f / total_merchants.to_f).round(2)
  end

  def collect_items_per_merchant
    sales_engine.merchants.all.map do |merchant|
      merchant.items.length
    end
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(collect_items_per_merchant).round(2)
  end

  def collect_invoices_per_merchant
    sales_engine.merchants.all.map do |merchant|
      merchant.invoices.length
    end
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(collect_invoices_per_merchant).round(2)
  end

  def items_given_merchant_id(merchant_id)
    merchant = sales_engine.find_merchant(merchant_id)
    merchant.items
  end

  def average_item_price_for_merchant(merchant_id)
    items = items_given_merchant_id(merchant_id)
    sum_of_prices = items.reduce(0) do |sum, item|
      sum += item.unit_price
    end
    (sum_of_prices / items.count).round(2)
  end

  def average_average_price_per_merchant
    all_merchants = sales_engine.merchants.all
    sum_of_averages = all_merchants.reduce(0) do |total, merchant|
      total += average_item_price_for_merchant(merchant.id)
      total
    end
    (sum_of_averages / total_merchants).round(2)
  end

  def get_all_prices
    prices = sales_engine.items.all.map do |item|
      item.unit_price
    end
  end

  def golden_prices
    above_standard_deviation(get_all_prices, 2)
  end

  def golden_items
    items = golden_prices.map do |price|
      sales_engine.items.find_all_by_price(price)
    end
    items.flatten.uniq
  end

  def number_of_items_for_every_merchant
    sales_engine.merchants.all.map do |merchant|
      merchant.items.length
    end
  end

  def merchants_with_high_item_count
    item_count = number_of_items_for_every_merchant
    cut = mean(item_count) + standard_deviation(item_count)
    sales_engine.merchants.all.find_all do |merchant|
      merchant.items.count > cut
    end
  end

  def top_merchants_by_invoice_count
    invoice_count = collect_invoices_per_merchant
    cut = mean(invoice_count) + 2 * standard_deviation(invoice_count)
    sales_engine.merchants.all.find_all do |merchant|
      merchant.invoices.count > cut
    end
  end

  def bottom_merchants_by_invoice_count
    invoice_count = collect_invoices_per_merchant
    cut = mean(invoice_count) - 2 * standard_deviation(invoice_count)
    sales_engine.merchants.all.find_all do |merchant|
      merchant.invoices.count < cut
      end
  end

  def find_invoice_status
   sales_engine.invoices.all.each_with_object(Hash.new(0)) do |invoice,counts|
     counts[invoice.status] += 1
   end
 end

 def invoice_status(status)
   ((find_invoice_status[status].to_f/ total_invoices.to_f) * 100).round(2)
 end

 def days_of_week
   { 0 => "Sunday",
     1 => "Monday",
     2 => "Tuesday",
     3 => "Wednesday",
     4 => "Thursday",
     5 => "Friday",
     6 => "Saturday",
    }
  end

  def invoices_per_day
    sales_engine.invoices.all.reduce(Array.new(7) {0}) do |days, invoice|
      days[invoice.created_at.wday] += 1
      days
    end
  end

  # def convert_dates_into_numerical_day_of_week
  #   sales_engine.invoices.all.map do |invoice|
  #     invoice.created_at.wday
  #   end
  # end
  #
  # def convert_numerical_day_of_week_into_day_of_week
  #   convert_dates_into_numerical_day_of_week.map do |number|
  #     days_of_week[number]
  # end
  #
  # def create_a_hash_with_counted_days_of_week
  #   sales_engine.convert_numerical_day_of_week_into_day_of_week.each_with_object(Hash.new(0)) do |number,counts|
  #     counts[number] += 1
  # end
  #
  # def average_number_of_invoices_per_day
  #   create_a_hash_with_counted_days_of_week.keys.reduce(:+).to_f / 7
  # end
  #
  # def top_days_by_invoice_count
  #   number_of
  #   cut = average_number_of_invoices_per_day + standard_deviation()
  #   sales_engine.merchants.all.find_all do |merchant|
  #     merchant.invoices.count > cut
  # end



end
