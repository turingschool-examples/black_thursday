require 'time'
require 'groupdate'

class SalesAnalyst

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  # private :merchant_list,
  #         :find_items,
  #         :find_standard_deviation_difference_total,
  #         :find_standard_deviation_total,
  #         :total_merchants_minus_one,
  #         :create_merchant_id_item_total_list,
  #         :standard_deviation_plus_average,
  #         :filter_merchants_by_items_in_stock
  # public

  def average_items_per_merchant
    merchant_count = @sales_engine.merchants.all.length
    item_count = @sales_engine.items.all.length
    (item_count.to_f/ merchant_count).round(2)
  end

  def merchant_list
    sales_engine.merchants.merchants.map { |merchant| merchant.id }
  end

  def find_items
    merchant_list.map do |merchant|
      sales_engine.items.find_all_by_merchant_id(merchant).count
    end
  end

  def find_standard_deviation_difference_total
    find_items.map do |item_total|
      (item_total - average_items_per_merchant) ** 2
    end.sum
  end

  def find_standard_deviation_total
    find_standard_deviation_difference_total / total_merchants_minus_one
  end

  def total_merchants_minus_one
    ((sales_engine.merchants.all.count) -1)
  end

  def average_items_per_merchant_standard_deviation
    Math.sqrt(find_standard_deviation_total).round(2)
  end

  def create_merchant_id_item_total_list
    Hash[merchant_list.zip find_items]
  end

  def standard_deviation_plus_average
    average_items_per_merchant_standard_deviation + average_items_per_merchant
  end

  def filter_merchants_by_items_in_stock
    create_merchant_id_item_total_list.find_all do |key, value|
      value >= standard_deviation_plus_average
    end
  end

  def merchants_with_high_item_count
    filter_merchants_by_items_in_stock.map do |merchants|
    sales_engine.merchants.find_by_id(merchants[0])
    end
  end

  def average_item_price_for_merchant(merchant_id)
    list = find_the_collections_of_items(merchant_id.to_s)
    (list.reduce(0) { |sum, item| sum + item.unit_price_to_dollars } / list.count).round(2)
  end

  def find_the_collections_of_items(merchant_id)
    sales_engine.items.find_all_by_merchant_id(merchant_id)
  end

  def average_average_price_for_merchant
    (merchant_list.reduce(0) { |sum, merchant|
      sum + average_item_price_for_merchant(merchant)
      } / merchant_list.count).round(2)
  end

  def average_unit_price
    @sales_engine.items.all.reduce(0) { |sum, item|
    sum + item.unit_price
     } / @sales_engine.items.all.count
  end

  def unit_price_and_average_difference_squared_sum
    @sales_engine.items.all.reduce(0) { |sum, item|
    sum += (item.unit_price - average_unit_price) ** 2 }
  end

  def unit_price_squared_sum_division
    unit_price_and_average_difference_squared_sum / ((@sales_engine.items.all.count) - 1)
  end

  def unit_price_standard_deviation
    Math.sqrt(unit_price_squared_sum_division).round(2)
  end

  def golden_items_deviation
    average_unit_price + (unit_price_standard_deviation * 2)
  end

  def golden_items
    @sales_engine.items.items.find_all do |item|
      item if item.unit_price_to_dollars >= golden_items_deviation
     end
  end

  def average_invoices_per_merchant
    (find_invoice_totals.reduce(0) { |sum, totals|
      sum += totals } / find_invoice_totals.count.to_f).round(2)
  end

  def find_invoice_totals
    merchant_list.map do |merchant|
      sales_engine.invoices.find_all_by_merchant_id(merchant).length
    end
  end

  def invoice_total_minus_average_squared
    find_invoice_totals.reduce(0) { |sum, total|
    sum += (total - average_invoices_per_merchant) ** 2 }
  end

  def invoice_difference_total_divided
    invoice_total_minus_average_squared / (find_invoice_totals.length - 1)
  end

  def average_invoices_per_merchant_standard_deviation
    Math.sqrt(invoice_difference_total_divided).round(2)
  end

  def invoice_count_two_standard_deviations_above_mean
    average_invoices_per_merchant +
    (average_invoices_per_merchant_standard_deviation * 2)
  end

  def invoice_count_two_standard_deviations_below_mean
    average_invoices_per_merchant -
    (average_invoices_per_merchant_standard_deviation * 2)
  end

  def top_merchants_by_invoice_count
    sum = invoice_count_two_standard_deviations_above_mean
    create_merchant_invoice_total_list.find_all do |key, value|
      value >= sum
    end
  end

  def bottom_merchants_by_invoice_count
    create_merchant_invoice_total_list.find_all do |key, value|
      value <= invoice_count_two_standard_deviations_below_mean
    end
  end

  def create_merchant_invoice_total_list
    Hash[merchant_list.zip find_invoice_totals]
  end

  def map_created_dates_to_weekdays
    @sales_engine.invoices.invoices.map do |invoice|
      invoice.created_at.strftime("%A")
    end
  end

  def invoice_totals_by_day
    map_created_dates_to_weekdays.each_with_object(Hash.new(0)) do
      |word, acc| acc[word] += 1
    end
  end

  def invoice_per_day_average
    invoice_totals_by_day.reduce(0) { |sum, (key, value) |
      sum += value } / invoice_totals_by_day.count
  end

  def invoice_totals_minus_average_squared
    invoice_totals_by_day.reduce(0) { |sum, (key, value) |
      sum += (value - invoice_per_day_average) ** 2 }
    end

  def weekday_invoice_total_difference_divided
    invoice_totals_minus_average_squared / ((invoice_totals_by_day.count) - 1)
  end

  def weekday_invoice_creation_standard_deviation
    Math.sqrt(weekday_invoice_total_difference_divided).round(2)
  end

  def invoice_creation_standard_deviation_plus_average
    weekday_invoice_creation_standard_deviation + invoice_per_day_average
  end

  def top_days_by_invoice_count
    invoice_totals_by_day.select do |key, value|
      value >= invoice_creation_standard_deviation_plus_average
    end.keys
  end

  def invoice_status(status)
    (find_all_invoices(status).length /
    sales_engine.invoices.all.length.to_f * 100).round(2)
  end

  def find_all_invoices(status)
    sales_engine.invoices.find_all_by_status(status)
  end

  def find_all_invoice_items_by_date(date)
    sales_engine.invoices.find_by_created_date(date)
  end

  # def total_revenue_by_date(date)
  #   find_all_invoices_by_date(date).map do |invoice|
  # end

  # def filter_invoices_for_result(invoices, status)
  #   invoices.find_all { |invoice| invoices.}

end
