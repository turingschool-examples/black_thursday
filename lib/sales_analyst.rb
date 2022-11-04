require 'pry'
require_relative './merchant_repository'
require_relative './item_repository'
require_relative './invoice_repository'
require_relative './invoice_item_repository'
require_relative './customer_repository'
require_relative './transaction_repository'
require_relative './item'
require_relative './merchant'
require_relative './invoice'
require_relative './invoice_item'
require_relative './customer'
require_relative './transaction'

class SalesAnalyst
  attr_reader :merchants, :items, :invoices, :customers, :transactions

  def initialize(merchants,items,invoices,customers,transactions)
    @merchants = merchants
    @items = items
    @invoices = invoices
    @customers = customers
    @transactions = transactions
  end

  def average_items_per_merchant
    (@items.all.count / @merchants.all.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation    
    Math.sqrt(sum_square_diff_items/(item_counts.length-1)).round(2)
  end

  def merchants_with_high_item_count
    avg = average_items_per_merchant
    stdev = average_items_per_merchant_standard_deviation

    @merchants.all.find_all do |merchant|
      @items.find_all_by_merchant_id(merchant.id).count > avg + stdev
    end
  end

  def average_item_price_for_merchant(id)
    sum = @items.find_all_by_merchant_id(id).sum do |item|
      item.unit_price
    end
    avg = sum.to_f / @items.find_all_by_merchant_id(id).count
    BigDecimal(avg,4)
  end

  def average_average_price_per_merchant
    sum = @merchants.all.sum do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    avg = sum / @merchants.all.count
    avg.truncate(2)
  end

  def golden_items
    avg = average_item_price
    stdev = Math.sqrt(sum_square_diff_golden/(@items.all.size-1)).round(2)
    @items.all.select do |item|
      item.unit_price > avg + 2*stdev
    end
  end

  # Helper methods

  def sum_square_diff_items
    item_counts.map do |count|
      (count - average_items_per_merchant)**2
    end.sum
  end
  
  def item_counts
    @merchants.all.map do |merchant|
      @items.find_all_by_merchant_id(merchant.id).count
    end
  end

  def sum_square_diff_golden
    @items.all.map do |item|
      (item.unit_price - average_item_price)**2
    end.sum
  end

  def average_item_price
    sum = @items.all.sum do |item|
      item.unit_price
    end
    (sum / @items.all.size).round(2)
  end

  def average_invoices_per_merchant
    (@invoices.all.count / @merchants.all.count.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    # binding.pry
    Math.sqrt(invoice_sum_square_diff / (invoice_count.length - 1)).round(2)
  end

  def invoice_sum_square_diff
    invoice_count.map do |count|
      (count - average_invoices_per_merchant)**2
    end.sum
  end

  def invoice_count
    @merchants.all.map do |merchant|
      @invoices.find_all_by_merchant_id(merchant.id).count
      # binding.pry
    end
  end

  def top_merchants_by_invoice_count
    average = average_invoices_per_merchant
    stdev = average_invoices_per_merchant_standard_deviation
    @merchants.all.find_all do |merchant|
    @invoices.find_all_by_merchant_id(merchant.id).count > average + (stdev * 2)
    # binding.pry
    end
  end

  def bottom_merchants_by_invoice_count
    average = average_invoices_per_merchant
    stdev = average_invoices_per_merchant_standard_deviation

    @merchants.all.find_all do |merchant|
    @invoices.find_all_by_merchant_id(merchant.id).count < average - (stdev * 2)
    end
  end

  def invoices_days_of_week
    @invoices.all.map do |invoice|
    invoice.created_at.wday
    end
  end

  def invoice_days_count
    # [708, 696, 692, 741, 718, 701, 729]
    days_count = []
    days_count << invoices_days_of_week.count(0)
    days_count << invoices_days_of_week.count(1)
    days_count << invoices_days_of_week.count(2)
    days_count << invoices_days_of_week.count(3)
    days_count << invoices_days_of_week.count(4)
    days_count << invoices_days_of_week.count(5)
    days_count << invoices_days_of_week.count(6)
    days_count
  end

  def average_invoices_per_day
    # binding.pry
  (invoice_days_count.sum / 7.0).round(2)
  end

  def average_invoices_per_week_standard_deviation
    Math.sqrt(invoice_week_sum_diff_square / (invoice_days_count.length - 1)).round(2)
  end

  def invoice_week_sum_diff_square
    invoice_days_count.map do |count|
      (count - average_invoices_per_day)**2
    end.sum
  end

  def one_over_standard_dev
    average_invoices_per_week_standard_deviation + average_invoices_per_day
  end

  def top_days_by_invoice_count # refactor with group_by, possibly refactor invoice_days_count to hash?
    days_of_week = []
    array = invoice_days_count
    hash = {
      sunday:     array[0],
      monday:     array[1],
      tuesday:    array[2],
      wednesday:  array[3],
      thursday:   array[4],
      friday:     array[5],
      saturday:   array[6]
            }
    hash.each do |day, count|
      if count > one_over_standard_dev
         days_of_week << day.to_s.capitalize
      end
    end
    days_of_week
  end

  def invoice_status(status)
  invoice_count = invoices.all.select { |invoice| invoice.status == status }
  ((invoice_count.count).to_f / (invoices.all.count) * 100).round(2)
  end
end