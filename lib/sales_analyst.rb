require './mathable'
require './time_helper'
require './merchants_repository'
require './items_repository'
require './invoice_repository'
require 'pry'

class Analyst
  include Mathable
  include TimeHelper

  def initialize
    @mr = MerchantsRepository.new("./data/merchants.csv")
    @ir = ItemsRepository.new("./data/items.csv")
    @in = InvoiceRepository.new("./data/invoices.csv")
  end

  def average_items_per_merchant
    average(@ir.repository.count.to_f, @mr.repository.count)
  end

  def average_items_per_merchant_standard_deviation
    merchant_item_numbers = @ir.merchant_ids.values.map { |list| list.count }
    stn_dev = standard_devation(merchant_item_numbers, average_items_per_merchant)
  end

  def merchants_with_high_item_count
    big_sellers = @ir.merchant_ids.select do |merchant, items|
      items.count > (average_items_per_merchant + average_items_per_merchant_standard_deviation)
    end
  end

  def average_item_price_per_merchant(merchant_id)
    items = @ir.find_all_by_merchant_id(merchant_id)
    unit_price_array = items.map { |price| price.unit_price}
    average_price = average(unit_price_array.sum, unit_price_array.count)
    in_dollars = (average_price / 100).round(2)
  end

  def average_average_price_per_merchant
    array_of_prices = @mr.repository.map do |merchant|
      average_item_price_per_merchant(merchant.id)
    end
    average = average(array_of_prices.sum, array_of_prices.count)
    return average
  end

  def golden_items
    list = @ir.repository.map { |item| item.unit_price.to_i}
    mean = average(list.sum, list.count)
    std_dev = standard_devation(list, mean)
    golden_items = @ir.repository.select do |gi|
      gi.unit_price.to_i > (mean + (std_dev * 2))
    end
  end

  def average_invoices_per_merchant
    average(@in.repository.count.to_f, @mr.repository.count)
  end

  def average_invoices_per_merchant_standard_deviation
    merchant_invoice_list = @in.merchant_ids.map { |id, invoices| invoices.count}
    std_dev = standard_devation(merchant_invoice_list, average_invoices_per_merchant)
  end

  def top_merchants_by_invoice_count
    top_sellers = @in.merchant_ids.select do |id, list|
      list.count > (average_invoices_per_merchant + (average_items_per_merchant_standard_deviation * 2))
    end
  end

  def bottom_merchants_by_invoice_count
    bottom_sellers = @in.merchant_ids.select do |id, list|
      list.count < (average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2))
    end
  end

  def top_days_by_invoice_count
    invoices_per_day = @in.call_weekdays.map { |day, invoices| invoices.count}
    mean = average(invoices_per_day.sum.to_f, invoices_per_day.count)
    std_dev = standard_devation(invoices_per_day, mean)
    top_days = @in.call_weekdays.select do |day, invoices|
      invoices.count > (mean + std_dev)
    end
    top_days.keys
  end

  def invoice_status(status)
    decimal = (@in.invoice_status[status].count.to_f / @in.repository.count)
    percentage = (decimal * 100).round(2)
  end


end
