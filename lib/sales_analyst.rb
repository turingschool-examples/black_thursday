require_relative 'sales_engine'
require_relative 'merchant_analysis'
require          'pry'
require          'pry'
require 'time'

class SalesAnalyst
  include MerchantAnalysis
  attr_reader :se

  def initialize(se)
    @se = se
  end

  def number_of_merchants
    se.merchants.all.count
  end

  def number_of_items
    se.items.all.count
  end

  def average_items_per_merchant #can't change
    se.merchants.average_items_per_merchant
  end

  def average_items_per_merchant_standard_deviation #can't change
    Math.sqrt(se.merchants.variance_items).round(2)
  end

  def one_standard_dev_above_mean_value
    average_items_per_merchant + average_items_per_merchant_standard_deviation
  end

  def merchants_with_high_item_count #can't change
    benchmark = one_standard_dev_above_mean_value
    se.merchants.all.find_all { |merchant|
       merchant.items.count > benchmark }
  end

  def merchants_items_prices(merchant_id)
    se.merchants.find_by_id(merchant_id).items.map do |item|
      item.unit_price
    end
  end

  def account_for_zero_items(total_items)
    if total_items.count == 0
      0
    else
      total_items.reduce(:+) / total_items.count
    end
  end

  def average_item_price_for_merchant(merchant_id) #can't change
    total = merchants_items_prices(merchant_id)
    (account_for_zero_items(total) / 100).round(2)
  end

  def all_merchants_averages
    se.merchants.all_merchants_ids.map { |merchant_id|
      average_item_price_for_merchant(merchant_id)}
  end

  def average_average_price_per_merchant #can't change
    total_averages = all_merchants_averages.reduce(:+)
    (total_averages / all_merchants_averages.count).round(2)
  end

  def average_prices_of_all_items
    se.items.average_prices_of_all_items
  end

  def average_items_price_standard_deviation_gi
    Math.sqrt(se.items.variance).round(2)
  end

  def two_standard_dev_above_mean_value_gi
     average_prices_of_all_items + (average_items_price_standard_deviation_gi * 2)
  end

  def golden_items
    benchmark = two_standard_dev_above_mean_value_gi
    se.items.all.find_all { |item| item.unit_price > benchmark }
  end
#======================================================
#Invoices Analysis

  # Average invoices per merchant==================================
  def average_invoices_per_merchant #can't change
    (se.merchants.invoices_per_merchant.inject(0.0,:+) / number_of_merchants).round(2)
  end

  # def number_of_invoices_per_merchant
  #   se.merchants.all.map {|merchant| merchant.invoices.count}
  # end

  # Standard deviation invoices ====================================
  def average_invoices_per_merchant_standard_deviation #can't change
    Math.sqrt(variance_invoices).round(2)
  end

  def variance_invoices
    sum_deviations_from_the_mean_invoices / (number_of_merchants - 1)
  end

  def sum_deviations_from_the_mean_invoices
    se.merchants.invoices_per_merchant.inject(0) do |accum, invoices|
      accum + (invoices - average_invoices_per_merchant) ** 2
    end
  end

  #Top Merchants ==================================================
  def top_merchants_by_invoice_count
    benchmark = two_standard_dev_above_mean_invoices
    se.merchants.all.find_all { |merchant|
       merchant.invoices.count > benchmark}
  end

  def two_standard_dev_above_mean_invoices
    average_invoices_per_merchant + (average_invoices_per_merchant_standard_deviation * 2)
  end

  #Bottom Merchants ==============================================
  def bottom_merchants_by_invoice_count
    benchmark = two_standard_dev_below_mean_invoices
    se.merchants.all.find_all { |merchant|
       merchant.invoices.count < benchmark }
  end

  def two_standard_dev_below_mean_invoices
    average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2)
  end

  #Top Days by Invoice Count =====================================
  def top_days_by_invoice_count
    hash_of_invoices_to_day_of_the_week
    return_weekday_hash_and_key_for_top_days.map do |days|
      days[0].to_s
    end
  end

  def one_standard_dev_above_mean_value_top_days
    average_invoices_per_day_standard_deviation + average_invoices_per_day
  end

  def return_weekday_hash_and_key_for_top_days
    benchmark = one_standard_dev_above_mean_value_top_days
    @wday_created.find_all { |wday_invoices|
      wday_invoices[1] > benchmark }
  end

  def hash_of_invoices_to_day_of_the_week
    days_of_the_week_hash
    se.invoices.all.each do |invoice|
      day = invoice.created_at.strftime('%A').to_sym
      @wday_created[day] = @wday_created[day] += 1
    end
    @wday_created
  end

  def days_of_the_week_hash
    @wday_created = { Sunday: 0,
                      Monday: 0,
                     Tuesday: 0,
                   Wednesday: 0,
                    Thursday: 0,
                      Friday: 0,
                    Saturday: 0
                  }
  end


  # Standard deviation for top days by invoice ================
  def average_invoices_per_day_standard_deviation
    Math.sqrt(variance_days)
  end

  def variance_days
    sum_deviations_from_the_mean_days / (days_of_the_week - 1)
  end

  def sum_deviations_from_the_mean_days
    invoices_per_day_of_the_week.inject(0) { |accum, invoices|
      accum + ((invoices - average_invoices_per_day) ** 2.0) }.to_f
      # 1958.8572
  end

  def invoices_per_day_of_the_week
    @wday_created.values
    # [708, 696, 692, 741, 718, 701, 729]
  end

  # Average invoices per day for top days by invoice============
  def average_invoices_per_day
    (number_of_invoices / days_of_the_week).round(2)
  end

  def number_of_invoices
    se.invoices.all.count
  end

  def days_of_the_week
    7.0
  end

  # Percentage of invoices not shipped ========================

  def percentage_of_invoices_shipped_vs_pending_vs_returned
    pending = invoice_status(:pending)
    shipped = invoice_status(:shipped)
    returned = invoice_status(:returned)
    "Percentage of invoices shipped: #{shipped}% vs.
    pending #{pending}% vs. returned #{returned}%"
  end

  def invoice_status(status)
    (percentage_of_invoice_pending(status).count / number_of_invoices.to_f * 100.0).round(2)
  end

  def percentage_of_invoice_pending(status)
    se.invoices.all.find_all do |invoice|
      invoice.status == status
    end
  end

  #iteration4 Total Revenue=================================
  def total_revenue_by_date(date)
    find_all_created_on_date(date).reduce(0.0) do |sum, invoice|
      if invoice.total == nil
        sum + 0
      else
       sum + invoice.total
      end
    end
  end

  def find_all_created_on_date(date)
    date = date.strftime("%Y-%m-%d")
    se.invoices.all.find_all do |invoice|
      invoice.created_at.to_s.include?(date)
    end
  end
#Top revenue earners ===========================================
  def most_sold_item_for_merchant(merchant_id)
    se.find_all_by_merchant_id(merchant_id)
    binding.pry
    # se.invoices.all.map do |invoice|
    #   invoice.most_sold_items
    # end
  end
end
