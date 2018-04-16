# frozen_string_literal: true
require 'time'
# sales analyst
class SalesAnalyst
  attr_reader :engine

  def initialize(engine)
    @engine = engine
    # binding.pry
  end

  def average_items_per_merchant
    (total_items_per_merchant.reduce(:+) / total_merchants.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    total = total_items_per_merchant
    standard_deviation(total, average_items_per_merchant).round(2)
  end

  # this method returns an array of all merchants whose
  #   total item count - average items per all merchants
  #   is greater than one standard deviation
  #
  # iterate over merchant objects, for each object subtract
  #   average items per all merchants from total items per merchant
  #   in the loop. return the merchant object in the array if
  #   the difference is greater than one standard deviation

  def merchants_with_high_item_count
    merchants.map do |merchant|
      difference = merchant.items.length - average_items_per_merchant
      merchant if difference > average_items_per_merchant_standard_deviation
    end.compact
  end

  def average_item_price_for_merchant(id)
    found ||= @engine.items.find_all_by_merchant_id(id)
    to_average = found.map do |item|
      item.unit_price
    end.reduce(:+) / found.length
    to_average.round(2)
  end

  def average_average_price_per_merchant
    @summed ||= sum_of_average_item_price_for_each_merchant
    (@summed / total_merchants).round(2)
  end

  def golden_items
    items.map do |item|
      difference = (item.unit_price - average_average_price_per_merchant)
      item if difference > average_item_price_standard_deviation * 2
    end.compact
  end

  def average_invoices_per_merchant
    (invoices.length / total_merchants.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    total_invoices = total_invoices_per_merchant
    standard_deviation(total_invoices, average_invoices_per_merchant).round(2)
  end

  def top_merchants_by_invoice_count
    avg_std_dev = average_invoices_per_merchant_standard_deviation
    avg = average_invoices_per_merchant
    merchants.map do |merchant|
      diff = (merchant.invoices.length - avg).to_f
      merchant if diff.abs > avg_std_dev * 2 && merchant.invoices.length > avg
    end.compact
  end

  def bottom_merchants_by_invoice_count
    avg_std_dev = average_invoices_per_merchant_standard_deviation
    avg = average_invoices_per_merchant
    merchants.map do |merchant|
      diff = (merchant.invoices.length - avg).to_f
      merchant if diff.abs > avg_std_dev * 2 && merchant.invoices.length < avg
    end.compact
  end

  def top_days_by_invoice_count
    hash = {}
    grouped = invoices.group_by { |invoice| invoice.created_at.wday }
    grouped.each { |key, value| hash[key] = value.size }
    mean = hash.values.reduce(:+) / 7
    std_dev = standard_deviation(hash.values, mean) + mean
    day_nums = hash.select { |_, v| v > std_dev }.keys
    days = day_nums.map { |num| Date::DAYNAMES[num] }
    days
  end

  def invoice_status(status)
    found = invoices.select { |invoice| invoice.status == status }
    (found.length.to_f / invoices.length.to_f * 100).round(2)
  end

  private

  def merchants
    @engine.merchants.all
  end

  def items
    @engine.items.all
  end

  def invoices
    @engine.invoices.all
  end

  def average_item_price_standard_deviation
    unit_prices = unit_price_of_all_items
    standard_deviation(unit_prices, average_average_price_per_merchant)
  end

  def standard_deviation(data, average)
    @calculated ||= data.map do |item|
      (item - average)**2
    end.reduce(:+) / (data.length - 1)
    Math.sqrt(@calculated)
  end

  def sum_of_average_item_price_for_each_merchant
    merchants.reduce(0) do |sum, merchant|
      sum + average_item_price_for_merchant(merchant.id)
    end
  end

  def total_items_per_merchant
    @_total ||= merchants.map do |merchant|
      merchant.items.length
    end
  end

  def total_invoices_per_merchant
    @_invoices ||= merchants.map do |merchant|
      merchant.invoices.length
    end
  end

  def total_merchants
    merchants.length
  end

  def unit_price_of_all_items
    items.map(&:unit_price)
  end
end
