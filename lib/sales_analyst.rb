require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/repo_method_helper.rb'
require 'date'


class SalesAnalyst
  attr_reader :merchant_repo,
              :item_repo,
              :invoice_repo
  include RepoMethodHelper


  def initialize(merchant_repo, item_repo, invoice_repo)
    @merchant_repo = merchant_repo
    @item_repo = item_repo
    @invoice_repo = invoice_repo
  end

  def sum(array)
    array.inject(0) do |sum, number|
      sum + number
    end
  end

  def average(numerator, denominator)
    average = numerator / denominator
    average.round(2)
  end

  def standard_deviation(array_of_values, calculated_average_of_values)
    stddev_sum = array_of_values.inject(0) do |sum, number|
      sum + ((number - calculated_average_of_values) ** 2)
    end
    divided = (stddev_sum / array_of_values.count)
    Math.sqrt(divided).round(2)
  end

  def average_items_per_merchant
    numerator = @item_repo.items.count
    denominator = @merchant_repo.merchants.count.to_f
    average(numerator, denominator)
  end

  def items_per_merchant
    @item_repo.items.each_with_object(Hash.new(0)) do |item, counts|
      counts[item.merchant_id] += 1
    end
  end

  def average_items_per_merchant_standard_deviation
    items_per_merchant_array = items_per_merchant.map do |key, value|
      value
    end
    standard_deviation(items_per_merchant_array, average_items_per_merchant)
  end

  def merchants_with_high_item_count
    one_stddev_up = (average_items_per_merchant + average_items_per_merchant_standard_deviation)

    merchant_ids = items_per_merchant.find_all do |merchant_id, item_count|
      item_count > one_stddev_up
    end
    merchant_ids.map do |merchant_id, item_count|
      @merchant_repo.find_by_id(merchant_id.to_i)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    item_list = @item_repo.find_all_by_merchant_id(merchant_id)

    prices = item_list.map do |item|
      item.unit_price
    end
    numerator = sum(prices).to_f
    denominator = items_per_merchant[merchant_id.to_s]
    average(numerator, denominator).to_d
  end

  def average_average_price_per_merchant
    total_average_price = @merchant_repo.merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id.to_i)
    end

    numerator = sum(total_average_price).to_f
    denominator = @merchant_repo.merchants.count
    average(numerator, denominator).to_d
  end

  def golden_items
    total_repo_value = @item_repo.items.inject(0) do |sum, item|
      sum + item.unit_price
    end

    unit_prices = @item_repo.items.map do |item|
      item.unit_price
    end

    average_price = total_repo_value / @item_repo.items.count
    stddev = standard_deviation(unit_prices, average_price)

    @item_repo.items.find_all do |item|
      item.unit_price > ((stddev * 2) + average_price)
    end
  end

  def average_invoices_per_merchant
    numerator = @invoice_repo.invoices.count
    denominator = @merchant_repo.merchants.count.to_f
    average(numerator, denominator)
  end

  def invoices_per_merchant
    @invoice_repo.invoices.each_with_object(Hash.new(0)) do |invoice, counts|
      counts[invoice.merchant_id] += 1
    end
    # binding.pry
  end

  def average_invoices_per_merchant_standard_deviation
    invoices_per_merchant_array = invoices_per_merchant.map do |key, value|
      value
    end
    standard_deviation(invoices_per_merchant_array, average_invoices_per_merchant)
  end

  def top_merchants_by_invoice_count
    stddev = average_invoices_per_merchant_standard_deviation

    top_merchants_and_counts_array = invoices_per_merchant.find_all do |merchant, invoice_count|
      invoice_count > ((stddev * 2) + average_invoices_per_merchant)
    end
    top_merchants_id_array = top_merchants_and_counts_array.map do |merchant|
      merchant[0]
    end
    top_merchants_id_array.map do |id|
      @merchant_repo.find_by_id(id)
    end
  end

  def bottom_merchants_by_invoice_count
    stddev = average_invoices_per_merchant_standard_deviation

    bottom_merchants_and_counts_array = invoices_per_merchant.find_all do |merchant, invoice_count|
      invoice_count < (average_invoices_per_merchant - (stddev * 2))
    end
    bottom_merchants_id_array = bottom_merchants_and_counts_array.map do |merchant|
      merchant[0]
    end
    bottom_merchants_id_array.map do |id|
      @merchant_repo.find_by_id(id)
    end
    # binding.pry
  end

  def average_invoice_counts_per_day
    numerator = @invoice_repo.invoices.count
    denominator = 7
    average(numerator, denominator)
  end

  def weekday(date_string)
    Date.parse(date_string).strftime("%A")
  end

  def top_days_by_invoice_count
    invoice_created_day_of_week = @invoice_repo.invoices.map do |invoice|
      weekday(invoice.created_at.to_s)
    end
    total_invoice_counts_by_day_of_week = invoice_created_day_of_week.each_with_object(Hash.new(0)) do |day, counts|
      counts[day] += 1
    end
    stddev = standard_deviation(total_invoice_counts_by_day_of_week.values, average_invoice_counts_per_day)

    pairs = total_invoice_counts_by_day_of_week.find_all do |day, count|
      count > (stddev + average_invoice_counts_per_day).round.to_i
    end
    pairs.map do |pair|
      pair[0]
    end
  end

  def invoice_status(status)
    denominator = @invoice_repo.invoices.count
    numerator = @invoice_repo.invoices.find_all do |invoice|
      invoice.status == status
    end.count
    percentage = (numerator / denominator.to_f) * 100
    percentage.round(2)
  end
end
