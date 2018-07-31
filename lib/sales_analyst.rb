require_relative '../lib/repo_method_helper.rb'
require 'date'


class SalesAnalyst
  include RepoMethodHelper

  attr_reader :merchant_repo,
              :item_repo,
              :invoice_repo,
              :invoice_item_repo,
              :transaction_repo,
              :customer_repo

  def initialize(merchant_repo, item_repo, invoice_repo, invoice_item_repo, transaction_repo, customer_repo)
    @merchant_repo = merchant_repo
    @item_repo = item_repo
    @invoice_repo = invoice_repo
    @invoice_item_repo = invoice_item_repo
    @transaction_repo = transaction_repo
    @customer_repo = customer_repo
  end

  def average_items_per_merchant
    numerator = @item_repo.list.count
    denominator = @merchant_repo.list.count.to_f
    average(numerator, denominator)
  end

  def items_per_merchant
    @item_repo.list.each_with_object(Hash.new(0)) do |item, counts|
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
    average(sum(prices).to_f, items_per_merchant[merchant_id.to_s]).to_d
  end

  def average_average_price_per_merchant
    total_average_price = @merchant_repo.list.map do |merchant|
      average_item_price_for_merchant(merchant.id.to_i)
    end
    average(sum(total_average_price).to_f, @merchant_repo.list.count).to_d
  end

  def golden_items
    average_price = total_item_repo_value / @item_repo.list.count
    stddev = standard_deviation(unit_prices_of_every_item, average_price)
    @item_repo.list.find_all do |item|
      item.unit_price > ((stddev * 2) + average_price)
    end
  end

  def average_invoices_per_merchant
    average(@invoice_repo.list.count, @merchant_repo.list.count.to_f)
  end

  def invoices_per_merchant
    @invoice_repo.list.each_with_object(Hash.new(0)) do |invoice, counts|
      counts[invoice.merchant_id] += 1
    end
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
    nan = top_merchants_id_array.map do |id|
      @merchant_repo.find_by_id(id)
    end
    # binding.pry
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
  end

  def average_invoice_counts_per_day
    numerator = @invoice_repo.list.count
    denominator = 7
    average(numerator, denominator)
  end

  def weekday(date_string)
    Date.parse(date_string).strftime("%A")
  end

  def top_days_by_invoice_count
    invoice_created_day_of_week = @invoice_repo.list.map do |invoice|
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
    denominator = @invoice_repo.list.count
    numerator = @invoice_repo.list.find_all do |invoice|
      invoice.status == status
    end.count
    percentage = (numerator / denominator.to_f) * 100
    percentage.round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    invoice_array = @transaction_repo.find_all_by_invoice_id(invoice_id)
    if invoice_array == []
      false
    else
      invoice_array.any? do |transaction|
        transaction.result == :success
      end
    end
  end

  def invoice_total(invoice_id)
    price_array = @invoice_item_repo.find_all_by_invoice_id(invoice_id)

    price_array.inject(0) do |sum, num|
        sum + (num.unit_price * num.quantity.to_i)
    end
  end

  def total_revenue_by_date(date)
    date_matched_invoices = @invoice_repo.list.find_all do |invoice|
      invoice.created_at == date
    end
    revenue_of_date_matched_invoices = date_matched_invoices.map do |invoice|
      invoice_total(invoice.id)
    end
    sum(revenue_of_date_matched_invoices)
  end

  def merchants_with_only_one_item
    merchant_list = []
    items_per_merchant.each do |merchant, item_count|
      if item_count == 1
        merchant_list << merchant
      end
    end

    merchant_list.map do |merchant_id|
      @merchant_repo.find_by_id(merchant_id.to_i)
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_with_only_one_item.find_all do |merchant|
      month_finder(merchant.created_at.to_s) == month
    end
  end

  def month_finder(month)
    Date.parse(month).strftime("%B")
  end

  def revenue_by_merchant(merchant_id)
    all_merchant_invoices = @invoice_repo.find_all_by_merchant_id(merchant_id)
    successful_invoices = all_merchant_invoices.find_all do |invoice|
      invoice_paid_in_full?(invoice.id)
    end
    revenue_of_successful_invoices = successful_invoices.map do |invoice|
      invoice_total(invoice.id)
    end
    sum(revenue_of_successful_invoices)
  end

  def merchants_ranked_by_revenue
    revenue_earned_per_merchant = @merchant_repo.list.map do |merchant|
      [merchant.id, revenue_by_merchant(merchant.id)]
    end
    sorted_highest_rev_per_mer = revenue_earned_per_merchant.sort_by do |merchant, revenue|
      revenue
    end.reverse
    sorted_highest_merchants = sorted_highest_rev_per_mer.map do |pair|
      pair[0]
    end
    sorted_highest_merchants.map do |id|
      @merchant_repo.find_by_id(id)
    end
  end

  def top_revenue_earners(number_of_top = 20)
    number_of_top = number_of_top - 1
    merchants_ranked_by_revenue[0..number_of_top]
  end

  def merchants_with_pending_invoices
    merchant_ids_of_pending = @invoice_repo.list.map do |invoice|
      invoice.merchant_id unless invoice_paid_in_full?(invoice.id)
    end.compact

    final = merchant_ids_of_pending.map do |merchant_id|
      @merchant_repo.find_by_id(merchant_id)
    end.uniq
  end

  def most_sold_item_for_merchant(merchant_id)
    merchant_invoices = @invoice_repo.find_all_by_merchant_id(merchant_id)
    invoice_items = merchant_invoices.map do |invoice|
      @invoice_item_repo.find_all_by_invoice_id(invoice.id) unless invoice_paid_in_full?(invoice.id) == false
    end.flatten.compact

    grouped_invoice_items = invoice_items.group_by do |invoice_item|
      invoice_item.item_id
    end

    hash = {}
    grouped_invoice_items.each do |key, value|
      hash[key] = value.inject(0) do |sum, num|
        sum + num.quantity.to_i
      end
    end

    highest_quantity = hash.values.max
    highest_values = hash.find_all do |key, value|
      value == highest_quantity
    end

    highest_values.map do |id, quantity|
      @item_repo.find_by_id(id)
    end
  end

  def best_item_for_merchant(merchant_id)
    merchant_invoices = @invoice_repo.find_all_by_merchant_id(merchant_id)
    invoice_items = merchant_invoices.map do |invoice|
      @invoice_item_repo.find_all_by_invoice_id(invoice.id) unless invoice_paid_in_full?(invoice.id) == false
    end.flatten.compact

    grouped_invoice_items = invoice_items.group_by do |invoice_item|
      invoice_item.item_id
    end

    hash = {}
    grouped_invoice_items.each do |key, value|
      hash[key] = value.inject(0) do |sum, num|
        sum + (num.quantity.to_i * num.unit_price)
      end
    end
    highest_quantity = hash.key(hash.values.max)
    @item_repo.find_by_id(highest_quantity)
  end

  ## -----HELPER METHODS--------------------------------------------------------

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

  def total_item_repo_value
    @item_repo.list.inject(0) do |sum, item|
      sum + item.unit_price
    end
  end

  def unit_prices_of_every_item
    @item_repo.list.map do |item|
      item.unit_price
    end
  end
end
