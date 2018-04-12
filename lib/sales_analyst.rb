require 'date'
require_relative 'analyzer'
# Sales Analyst class for analyzing data
class SalesAnalyst
  include Analyzer

  attr_reader :engine
  def initialize(sales_engine)
    @engine = sales_engine
    @merchant_repo = @engine.merchants
    @item_repo = @engine.items
    @invoice_repo = @engine.invoices
  end

  def average_items_per_merchant
    number_of_merchants = @merchant_repo.all.count
    number_of_items = @item_repo.all.count
    average(number_of_items, number_of_merchants).to_f
  end

  # Needs a test
  def items_per_merchant
    @item_repo.all.group_by(&:merchant_id)
  end

  def number_of_items_per_merchant
    number_of_items_per_merchant = items_per_merchant
    number_of_items_per_merchant.each do |id, items|
      number_of_items_per_merchant[id] = items.length
    end
    number_of_items_per_merchant
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(number_of_items_per_merchant.values, average_items_per_merchant)
  end

  def merchants_with_high_item_count
    std_dev = average_items_per_merchant_standard_deviation
    avg = average_items_per_merchant
    number_of_items_per_merchant.map do |id, num_of_items|
      @merchant_repo.find_by_id(id) if num_of_items >= avg + std_dev
    end.compact
  end

  def average_item_price_for_merchant(merchant_id)
    sum_of_prices = items_per_merchant[merchant_id].inject(0) do |sum, item|
      sum + item.unit_price
    end
    average(sum_of_prices, number_of_items_per_merchant[merchant_id])
  end

  def average_average_price_per_merchant
    all_merchants = @merchant_repo.all
    all_averages = all_merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    average(all_averages.inject(:+), all_averages.count )
  end

  def average_item_price
    total_items = @item_repo.all.count
    all_item_prices = @item_repo.all.map(&:unit_price)
    average(all_item_prices.inject(:+), total_items)
  end

  def average_item_price_standard_deviation
    standard_deviation(@item_repo.items.values.map(&:unit_price).sort, average_item_price)
  end

  def golden_items
    items = @item_repo.all
    deviation = average_item_price + (average_item_price_standard_deviation * 2)
    items.map do |item|
      item if item.unit_price >= deviation
    end.compact
  end

  def average_invoices_per_merchant
    average(@invoice_repo.all.count, @merchant_repo.all.count).to_f
  end

  def average_invoices_per_merchant_standard_deviation
    unique_merchants = @invoice_repo.all.map(&:merchant_id).uniq
    number_of_invoices_per_merchant = unique_merchants.map do |merchant_id|
      invoice_count(merchant_id)
    end
    standard_deviation(number_of_invoices_per_merchant, average_invoices_per_merchant)
  end

  def average_invoices_per_day
    average(@invoice_repo.all.count, @invoice_repo.all.map(&:created_at).uniq.count).to_f
  end
####
  def average_invoices_per_day_standard_deviation
    unique_days = @invoice_repo.all.map(&:created_at).uniq
    set = unique_days.map do |date|
      @invoice_repo.find_all_by_created_date(date).count
    end
    standard_deviation(set, average_invoices_per_day)
  end

  def invoice_count(merchant_id)
    @invoice_repo.find_all_by_merchant_id(merchant_id).count
  end

  def invoice_count_by_created_date(created_date)
    @invoice_repo.find_all_by_created_date(created_date).count
  end
# ++++++++++++============
  def invoices_per_merchant
    @invoice_repo.all.group_by(&:merchant_id)
  end

  def number_of_invoices_per_merchant
    number_of_invoices_per_merchant = invoices_per_merchant
    number_of_invoices_per_merchant.each do |id, invoices|
      number_of_invoices_per_merchant[id] = invoices.length
    end
    number_of_invoices_per_merchant
  end

  def merchants_per_count
    merchants_per_count = {}
    number_of_invoices_per_merchant.each do |id, count|
      if merchants_per_count[count]
        merchants_per_count[count] << id
      else
        merchants_per_count[count] = [] << id
      end
    end
    merchants_per_count
  end

  def average_invoices_per_merchant_plus_two_standard_deviations
    (average_invoices_per_merchant + (average_invoices_per_merchant_standard_deviation*2)).round(2)
  end

  def average_invoices_per_merchant_minus_two_standard_deviations
    (average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation*2)).round(2)
  end

  def top_merchants_by_invoice_count
    top_merchant_ids = merchants_per_count.map do |count, merchant_ids|
      merchant_ids if count >= average_invoices_per_merchant_plus_two_standard_deviations
    end.flatten.compact

    top_merchant_ids.map do |merchant_id|
      @merchant_repo.find_by_id(merchant_id)
    end
  end

  def bottom_merchants_by_invoice_count
    top_merchant_ids = merchants_per_count.map do |count, merchant_ids|
      merchant_ids if count <= average_invoices_per_merchant_minus_two_standard_deviations
    end.flatten.compact

    top_merchant_ids.map do |merchant_id|
      @merchant_repo.find_by_id(merchant_id)
    end
  end

  def top_days_by_invoice_count
    1
  end
end
