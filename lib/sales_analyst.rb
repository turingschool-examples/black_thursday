require_relative '../lib/repo_method_helper.rb'
require 'date'


class SalesAnalyst
  attr_reader :merchant_repo,
              :item_repo,
              :invoice_repo,
              :invoice_item_repo,
              :transaction_repo,
              :customer_repo

  include RepoMethodHelper


  def initialize(merchant_repo, item_repo, invoice_repo, invoice_item_repo, transaction_repo, customer_repo)
    @merchant_repo = merchant_repo
    @item_repo = item_repo
    @invoice_repo = invoice_repo
    @invoice_item_repo = invoice_item_repo
    @transaction_repo = transaction_repo
    @customer_repo = customer_repo
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

  def invoice_paid_in_full?(invoice_id)
    invoice_array = @transaction_repo.find_all_by_invoice_id(invoice_id)
    if invoice_array == []
      false
    else
      invoice_array.all? do |transaction|
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
    date_matched_invoices = @invoice_repo.invoices.find_all do |invoice|
      invoice.created_at == date
    end
    revenue_of_date_matched_invoices = date_matched_invoices.map do |invoice|
      invoice_total(invoice.id)
    end
    sum(revenue_of_date_matched_invoices)
  end

  def merchants_with_only_one_item

  end
  # def revenue_by_merchant(merchant_id)
  #   all_merchant_invoices = @invoice_repo.find_all_by_merchant_id(merchant_id)
  #   transactions = all_merchant_invoices.map do |invoice|
  #     @transaction_repo.find_all_by_invoice_id(invoice.id)
  #
  #   end.flatten.compact
  #   # binding.pry
  #   array = transactions.find_all do |transaction|
  #     # binding.pry
  #     transaction.result == :success
  #   end
  #
  #   successful_invoices = array.map do |transaction|
  #     @invoice_repo.find_by_id(transaction.invoice_id)
  #   end
  #
  #   revenue_per_invoice = successful_invoices.map do |invoice|
  #    if invoice.status != :returned
  #      invoice_total(invoice.id)
  #    end
  #  end
  #
  #   # revenue_per_invoice = success_and_shipped.map do |invoice|
  #   #   invoice_total(invoice.id)
  #   # end
  #   # binding.pry
  #   sum(revenue_per_invoice.compact)
  # end
  #
  # def revenue_by_merchant(merchant_id)
  #   all_merchant_invoices = @invoice_repo.find_all_by_merchant_id(merchant_id)
  #   revenue_per_invoice = all_merchant_invoices.map do |invoice|
  #     # if invoice.status == :shipped
  #     invoice_total(invoice.id)
  #     # end
  #   end
  #   sum(revenue_per_invoice.compact)
  # end

  # def top_revenue_earners(number_of_top = 20)
  #   number_of_top = number_of_top - 1
  #
  #   revenue_earned_per_merchant = @merchant_repo.merchants.map do |merchant|
  #     [merchant.id, revenue_by_merchant(merchant.id)]
  #   end
  #
  #   sorted_highest_rev_per_mer = revenue_earned_per_merchant.sort_by do |merchant, revenue|
  #     revenue
  #   end.reverse
  #
  #   sorted_highest_merchants = sorted_highest_rev_per_mer.map do |pair|
  #     pair[0]
  #   end
  #
  #   top_revenue_merchants_descending = sorted_highest_merchants.map do |id|
  #     @merchant_repo.find_by_id(id)
  #   end
  #   top_revenue_merchants_descending[0..number_of_top]
  #   binding.pry
  # end

  # def merchants_with_pending_invoices
  #   status_of_invoices_per_merchant = @merchant_repo.merchants.map do |merchant|
  #     [merchant.id, status_of_invoices_by_merchant(merchant.id)]
  #   end
  #   merchant_with_pending_invoices = status_of_invoices_per_merchant.find_all do |merchant, invoice_status|
  #     invoice_status.any? do |status|
  #       status == :pending
  #     end
  #   end
  #   merchant_with_pending_invoices.map do |merchant_id, invoice_status|
  #       @merchant_repo.find_by_id(merchant_id)
  #   end
  # end
# #helper method for pending invoices
#   def status_of_invoices_by_merchant(merchant_id)
#     all_merchant_invoices = @invoice_repo.find_all_by_merchant_id(merchant_id)
#     all_merchant_invoices.map do |invoice|
#       invoice.status
#     end
#   end
#--------------------------

end
