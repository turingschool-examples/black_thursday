require_relative './sales_engine'
require_relative './items'
require_relative './merchants'
require_relative './items_repo'
require_relative './merchants_repo'
require_relative './invoices'
require_relative './invoices_repo'
require 'csv'

class SalesAnalyst
  attr_reader :items_repo,
              :merchants_repo,
              :invoices_repo

  def initialize(items_repo, merchants_repo, invoices_repo)
    @items_repo     = items_repo
    @merchants_repo = merchants_repo
    @invoices_repo  = invoices_repo
  end

  def all_items
    @items_repo.all
  end

  def all_merchants
    @merchants_repo.all
  end

  def all_invoices
    @invoices_repo.all
  end

  def average_items_per_merchant
    total = (all_items.count / all_merchants.count.to_f).round(2)
  end

  def merchant_id_array
    all_merchants.map do |merchant|
      merchant.id
    end
  end

  def items_per_merchant
    merchant_id_array.map do |id|
      @items_repo.find_all_by_merchant_id(id).length
    end
  end

  def average_items_per_merchant_standard_deviation
    squared_differences = items_per_merchant.map do |num|
      ((num - average_items_per_merchant)**2).to_f
    end.sum
    divided_sum = ((squared_differences) / (merchant_id_array.length - 1))
    square_root = ((divided_sum)**0.5).to_f
    square_root.round(2)
  end

  def z_score_items(value)
    ((value - average_items_per_merchant) / average_items_per_merchant_standard_deviation).to_f
  end

  def z_score_price(value)
    ((value - average_average_price_per_merchant) /average_unit_price_standard_deviation).to_f
  end

  def average_unit_price
    prices = all_items.map do |item|
      item.unit_price
    end
    average = (prices.sum) / all_items.length
  end

  def average_unit_price_standard_deviation
    prices = all_items.map do |item|
      item.unit_price
    end
    squared_differences = prices.sum do |price|
      ((price - average_unit_price)**2).to_f
    end
    divided_sum = ((squared_differences) / (prices.length - 1))
    square_root = ((divided_sum)**0.5).to_f
    square_root.round(2)
  end

  def merchants_num_items_hash
    merchant_id_hash_keys = []
    all_merchants.each do |merchant|
      merchant_id_hash_keys << merchant.id
    end
    merchants_num_items_hash = Hash[merchant_id_hash_keys.zip(items_per_merchant)]
  end

  def merchants_with_high_item_count
    merchant_ids_with_high_item_count = []
    merchants_num_items_hash.each do |merchant_id, num|
      if z_score(num) >= 1.0
        merchant_ids_with_high_item_count << merchant_id
      end
    end
    merchant_ids_with_high_item_count.map do |merchant_id|
      @merchants_repo.find_by_id(merchant_id)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    items_for_current_merchant = @items_repo.find_all_by_merchant_id(merchant_id)
    prices_of_items_for_current_merchant = items_for_current_merchant.map do |item|
      item.unit_price
    end
    total_unit_price = prices_of_items_for_current_merchant.sum
    average_unit_price = total_unit_price / items_for_current_merchant.length
    result = BigDecimal(average_unit_price).round(2)
  end

  def average_average_price_per_merchant
    array_of_average_item_prices = all_merchants.map do |merchant|
      merchant_id = merchant.id
      average_item_price_for_merchant(merchant_id)
    end
    sum = array_of_average_item_prices.sum
    average = sum / array_of_average_item_prices.length
    result = BigDecimal(average).round(2)
  end

  def golden_items
    sorted_items = all_items.sort_by do |item|
      item.unit_price
    end.reverse!
    top_items_by_price = sorted_items.take(10)
    top_items_by_price.find_all do |item|
      z_score_price(item.unit_price) >= 2.0
    end
  end

  def average_invoices_per_merchant
    total = (all_invoices.count / all_merchants.count.to_f).round(2)
  end

  def invoices_per_merchant
    merchant_id_array.map do |id|
      @invoices_repo.find_all_by_merchant_id(id).length
    end
  end

  def average_invoices_per_merchant_standard_deviation
    squared_differences = invoices_per_merchant.sum do |num|
      ((num - average_invoices_per_merchant)**2).to_f
    end
    divided_sum = ((squared_differences) / (merchant_id_array.length - 1))
    square_root = ((divided_sum)**0.5).to_f
    square_root.round(2)
  end

  def z_score_invoices(value)
    ((value - average_invoices_per_merchant) / average_invoices_per_merchant_standard_deviation).to_f
  end

  def merchants_num_invoices_hash
    merchant_id_hash_keys = []
    all_merchants.each do |merchant|
      merchant_id_hash_keys << merchant.id
    end
    merchants_num_invoices_hash = Hash[merchant_id_hash_keys.zip(invoices_per_merchant)]
  end

  def top_merchants_by_invoice_count
    merchant_ids_with_high_invoice_count = []
    merchants_num_invoices_hash.each do |merchant_id, num|
      if z_score_invoices(num) >= 2.0
        merchant_ids_with_high_invoice_count << merchant_id
      end
    end
    merchant_ids_with_high_invoice_count.map do |merchant_id|
      @merchants_repo.find_by_id(merchant_id)
    end
  end

  def bottom_merchants_by_invoice_count
    merchant_ids_with_low_invoice_count = []
    merchants_num_invoices_hash.each do |merchant_id, num|
      if z_score_invoices(num) <= -2.0
        merchant_ids_with_low_invoice_count << merchant_id
      end
    end
    merchant_ids_with_low_invoice_count.map do |merchant_id|
      @merchants_repo.find_by_id(merchant_id)
    end
  end

  def invoices_per_day
    days_of_week = [0, 1, 2, 3, 4, 5, 6]

    days_of_week.map do |day|
      all_invoices.count do |invoice|
        invoice.created_at.wday == day
      end
    end
  end

  def top_days_by_invoice_count
    days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
    average_invoices_per_day = (invoices_per_day.sum) / days.length

    squared_diff = invoices_per_day.sum do |day|
      (day - average_invoices_per_day)**2
    end
    divided_sum = (squared_diff) / (days.length - 1)
    square_root = divided_sum**0.5.to_f
    standard_deviation = square_root.round(2)

    days_invoices_hash = days.zip(invoices_per_day)

    top_days = []
    days_invoices_hash.each do |day, num_of_invoices|
      if ((num_of_invoices - average_invoices_per_day) / standard_deviation) > 1
        top_days << day
      end
    end
    top_days
  end

  def invoice_status(status)
    s_status = status.to_s
    num_of_matching_invoices = all_invoices.find_all do |invoice|
      invoice.status == s_status
    end.length
    rough = ((num_of_matching_invoices.to_f / all_invoices.length.to_f) * 100)
    result = rough.round(2)
  end 
end
