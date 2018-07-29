require_relative 'merchant_repo'
require_relative 'item_repo'
require_relative 'invoice_repo'
require 'time'
require 'bigdecimal'

class SalesAnalyst

  attr_reader :merchants, :items, :invoices

  def initialize(merchant_repo, item_repo, invoice_repo)
    @merchants = merchant_repo
    @items = item_repo
    @invoices = invoice_repo
  end

  def average_items_per_merchant
    total_items = @items.all.count.to_f
    total_merchants = @merchants.all.count.to_f
    (total_items / total_merchants).round(2)
  end

  def return_unique_merchants
    if @merchants != nil
      return @merchants.all.uniq do |merchant|
        merchant.id
      end
    end
  end

  def total_items_per_merchant
    merchants = return_unique_merchants
    merchant_item_total = []
    merchants.each do |merchant|
      merchant_items = @items.all.find_all do |item|
        item.merchant_id == merchant.id
      end
      merchant_item_total << merchant_items.count
    end
    merchant_item_total
  end

  def differences_from_average
    total_items_per_merchant.map do |amount|
      amount.to_f - average_items_per_merchant
    end
  end

  def square_each_amount
    differences_from_average.map do |amount|
      amount * amount
    end
  end

  def sum_amount
    square_each_amount.inject(0) do |sum, amount|
      sum += amount
    end
  end

  def average_items_per_merchant_standard_deviation
    differences_from_average
    square_each_amount
    sum = sum_amount
    result = sum / (@merchants.all.count - 1)
    result = Math.sqrt(result).round(2)
  end

  def merchants_ids_for_high_item_count
    high_item_count = average_items_per_merchant_standard_deviation + average_items_per_merchant
    id_count_pair = return_unique_merchants.zip(total_items_per_merchant)
    merchant_ids = id_count_pair.find_all do |pair|
      if pair[1] >= high_item_count
        pair[0]
      end
    end
  end

  def merchants_with_high_item_count
    pairs = merchants_ids_for_high_item_count
    pairs.map do |pair|
      pair.reverse
      pair.pop
    end
    pairs.flatten
  end

  def average_item_price_for_merchant(merchant_id)
    total_items = @items.find_all_by_merchant_id(merchant_id)
    total_prices = total_items.inject(0) do |sum, item|
      sum += item.unit_price
    end
    average_item_price = total_prices / total_items.count
    average_item_price.round(2)
  end

  def all_average_prices
    average_prices = @merchants.all.map do |merchant|
      merchant_id = merchant.id
      average_item_price_for_merchant(merchant_id)
    end
  end

  def average_average_price_per_merchant
    average_summed = all_average_prices.inject(0) do |sum, price|
      sum += price
    end
    average_average_price = average_summed / @merchants.all.count
    average_average_price.round(2)
  end

  def average_item_price
    prices_summed = @items.all.inject(0) do |sum, item|
      sum += item.unit_price
    end
    prices_summed / @items.all.count
  end

  def all_item_prices
   @items.all.map do |item|
    item.unit_price
    end
  end

  def differences_from_average_price
    all_item_prices.map do |price|
      price.to_f - average_item_price
    end
  end

  def square_differences
    differences_from_average_price.map do |amount|
      amount * amount
    end
  end

  def sum_prices
    square_differences.inject(0) do |sum, amount|
      sum += amount
    end
  end

  def standard_deviation
    differences_from_average_price
    square_differences
    sum_prices
    result = sum_prices/ (@items.all.count - 1)
    result = Math.sqrt(result).round(2)
  end

  def golden_items
    high_item_price = standard_deviation * 2 + average_item_price
    golden = []
    @items.all.each do |item|
      if item.unit_price >= high_item_price
        golden << item
      end
    end
    golden
  end

  
