require_relative 'sales_engine'
require 'pry'

class SalesAnalyst
  def initialize(sales_engine)
    @sales_engine = sales_engine
    @merchants = sales_engine.merchants
    @items = sales_engine.items
    @invoices = sales_engine.invoices
  end

  def items_count
    @items.id_repo.count.to_f
  end

  def merchants_count
    @merchants.id_repo.count.to_f
  end

  def invoices_count
    @invoices.id_repo.count.to_f
  end

  def average_item_price
    (total_of_all_prices / items_count).round(2)
  end

  def average_items_per_merchant
    (items_count / merchants_count).round(2)
  end

  def average_price_per_merchant
    (total_of_all_prices / merchants_count).round(2)
  end

  def average_invoices_per_merchant
    (invoices_count / merchants_count).round(2)
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = @merchants.find_by_id(merchant_id)
    if !(merchant.nil?)
      total = merchant.items.reduce(0) do |total_price, item|
        total_price += item.unit_price
        total_price
      end
      (total / merchant.items.count).round(2)
    end
  end

  def total_of_all_prices
    @items.price_repo.keys.reduce(0) do |item_price_sum, price|
      @items.find_all_by_price(price).count.times do
        item_price_sum += price
      end
      item_price_sum
    end
  end

  def standard_deviation(average, numerator_repo, numerator_attribute_proc, total)
    numerator = numerator_repo.keys.reduce(0) do |sum, identifier|
      object = numerator_repo[identifier]
      proc_call = numerator_attribute_proc.call(object)
      sum += (proc_call - average) ** 2
      sum
    end
    divided_result = numerator / total
    Math.sqrt(divided_result).round(2)
  end

  def average_items_per_merchant_standard_deviation
    number_of_items = Proc.new {|merchant| merchant.items.count}
    standard_deviation(average_items_per_merchant, @merchants.id_repo, number_of_items, merchants_count)
  end

  def item_price_standard_deviation
    find_price = Proc.new {|item| item.unit_price}
    standard_deviation(average_item_price, @items.id_repo, find_price, items_count)
  end

  def average_invoices_per_merchant_standard_deviation
    invoices_per_merchant = Proc.new {|merchant| merchant.invoices}
    standard_deviation(average_invoices_per_merchant, @merchants.id_repo, invoices_per_merchant, merchants_count)
  end

  def merchants_with_high_item_count
    average = average_items_per_merchant
    standard_dev = average_items_per_merchant_standard_deviation
    @merchants.id_repo.keys.reduce([]) do |merchant_results, id|
      merchant = @merchants.find_by_id(id)
      if merchant.items.count > average + standard_dev
        merchant_results << merchant
      end
      merchant_results
    end
  end

  def golden_items
    two_stndv_above_avg = (item_price_standard_deviation * 2) + average_item_price
    @items.price_repo.keys.reduce([]) do |results, price|
      if price >= two_stndv_above_avg
        results << @items.price_repo[price]
      end
      results.flatten
    end
  end

end
