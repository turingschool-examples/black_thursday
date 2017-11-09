require 'time'
require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :sales_engine,
              :standard_dev,
              :golden_items_dev

  def initialize(sales_engine)
    @sales_engine           = sales_engine
    @standard_dev           = average_items_per_merchant_standard_deviation
    @golden_items_dev       = golden_items_deviation
    # @ave_inv_per_merch_std  = average_invoices_per_merchant_standard_deviation
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
    end.sum.round(2)
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
    @standard_dev + average_items_per_merchant
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
    list = find_the_collections_of_items(merchant_id)
    ((((list.reduce(0) { |sum, item| sum + item.unit_price.round(2) }) / (list.count))).round(2))
  end

  def find_the_collections_of_items(merchant_id)
    sales_engine.items.find_all_by_merchant_id(merchant_id)
  end

  def average_average_price_per_merchant
    (merchant_list.reduce(0) { |sum, merchant|
      sum + average_item_price_for_merchant(merchant)
    } / merchant_list.count).round(2)
  end

  def average_unit_price
    (@sales_engine.items.all.reduce(0) { |sum, item|
    sum + item.unit_price
  } / @sales_engine.items.all.count).round(2)
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
    (average_unit_price + (unit_price_standard_deviation * 2))
  end

  def golden_items
    @sales_engine.items.items.find_all do |item|
      item if item.unit_price >= @golden_items_dev
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
    (invoice_total_minus_average_squared / (find_invoice_totals.length - 1))
  end

  def average_invoices_per_merchant_standard_deviation
    (Math.sqrt(invoice_difference_total_divided).round(2))
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
    sum = invoice_count_two_standard_deviations_below_mean
    create_merchant_invoice_total_list.find_all do |key, value|
      value <= sum
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

  def find_all_invoices_by_date(date)
    sales_engine.invoices.find_all_by_created_date(date)
  end

  def filter_valid_invoices(invoices)
    invoices.reduce([]) do |result, invoice|
      result << invoice if invoice.is_paid_in_full? == true
    end
  end

  def find_invoice_items_for_invoice_collection(invoices)
    invoices.reduce([]) do |result, invoice|
      result << invoice.invoice_items
    end.flatten
  end

  def total_invoice_items_price(invoice_items)
    invoice_items.reduce(0) do |total, invoice_item|
      total += (invoice_item.quantity * invoice_item.unit_price)
    end
  end

  def total_revenue_by_date(date)
    invoices = find_all_invoices_by_date(date)
    filtered_invoices = filter_valid_invoices(invoices)
    invoice_items = find_invoice_items_for_invoice_collection(invoices)
    unit_price_to_dollars(total_invoice_items_price(invoice_items))
  end

  def unit_price_to_dollars(unit_price)
    (BigDecimal.new(unit_price).round(2))
  end

  def valid_invoices
    @sales_engine.invoices.all.find_all do |invoice|
      invoice.is_paid_in_full?
    end
  end

  def invalid_invoices
    @sales_engine.invoices.all.find_all do |invoice|
      invoice.is_paid_in_full? == false
    end
  end

  def missing_merchants
    sales_engine.merchants.all.find_all do |merchant|
      merchant.valid_invoices.count == 0
    end
  end

  def valid_inv_grouped_by_merchant
    valid_invoices.group_by do |invoice|
      invoice.merchant_id
    end
  end
  #
  # missing_merchant.each {|merchant| a.merge({merchant.id => 0})}

  def invoice_totals(invoices)
    invoices.reduce(0) do |sum, invoice|
      sum += invoice.total
    end
  end

  def total_of_invoices_per_merchant
    valid_inv_grouped_by_merchant.reduce({}) do |result, pair|
      result.update pair.first => (invoice_totals(pair.last))
    end
  end

  def fill_in_missing_merchants
    merchants_by_rev = total_of_invoices_per_merchant
    missing_merchants.each do |merchant|
      merchants_by_rev[merchant.id] = 0
    end
    merchants_by_rev
  end

  def merchants_by_revenue
    fill_in_missing_merchants.sort_by do |key, value|
      value
    end.reverse
  end

  def convert_revenue_to_merchants
    merchants_by_revenue.map do |merchant_rev|
      @sales_engine.merchants.find_by_id(merchant_rev.first)
    end
  end

  def top_revenue_earners(count = 20)
    merchants = convert_revenue_to_merchants
    merchants.first(count)
  end

  def merchants_ranked_by_revenue
    convert_revenue_to_merchants
  end

  def merchants_with_only_one_item
    @sales_engine.merchants.all.find_all do |merchant|
      merchant.items.count == 1
    end
  end

  def merchants_with_invalid_invoices
    invalid_invoices.map do |invoice|
      invoice.merchant_id
    end.uniq
  end

  def merchants_with_pending_invoices
    merchants_with_invalid_invoices.map do |merchant_id|
      sales_engine.merchants.find_by_id(merchant_id)
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
      merchants_with_only_one_item.find_all do |merchant|
        (merchant.created_at).strftime("%B") == month
      end
    end

  def revenue_by_merchant(id)
    invoice_totals(@sales_engine.merchants.find_by_id(id).invoices)
  end

  def valid_invoices_for_merchant(id)
    valid_invoices.find_all do |invoice|
      invoice.merchant_id == id
    end.flatten
  end

  def invoice_items_for_merchant(id)
    valid_invoices_for_merchant(id).map do |invoice|
      invoice.invoice_items
    end.flatten
  end

  def item_id_list_for_given_merchant(id)
    invoice_items_for_merchant(id).map do |invoice_item|
      invoice_item.item_id
    end
  end

  def frequency_list_for_items(id)
    item_id_list_for_given_merchant(id).reduce(Hash.new(0)) do |result, item|
      result[item] += 1
      result
    end
  end

  def most_frequent_item_on_list(id)
    frequency_list_for_items(id).max_by do |key, value|
        value
    end
  end

  def most_sold_item_for_merchant(id)
    most_frequent_item_on_list(id).map do |item_id|
      sales_engine.items.find_by_id(item_id)
    end
  end

  def freq_of_inv_item_for_merch(id)
    invoice_items_for_merchant(id).reduce(Hash.new(0)) do |result, item|
      result[item] += 1
      result
    end
  end

  def total_of_items_sold_assigned_to_invoice_item(id)
    freq_of_inv_item_for_merch(id).reduce(Hash.new(0)) do |result,(key, value)|
      result[key] = (key.unit_price * key.quantity * value)
      result
    end
  end

  def highest_inv_item_revenue(id)
    total_of_items_sold_assigned_to_invoice_item(id).max_by do |key, value|
      value
    end
  end

  def best_item_for_merchant(id)
    @sales_engine.items.find_by_id(highest_inv_item_revenue(id).first.item_id)
  end

end
