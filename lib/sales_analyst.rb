require_relative 'sales_engine'
require 'pry'

class SalesAnalyst

  include Math

  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    (@se.items.items.count.to_f / @se.merchants.merchants.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    merchant_items = number_of_items_per_merchant
    variance = get_variance_merchants(merchant_items)
    sqrt(variance.sum / (@se.merchants.merchants.count.to_f - 1)).round(2)
  end

  def number_of_items_per_merchant
    number_of_items_per_merchant = []
    @se.merchants.merchants.each do |merchant_obj|
      merchant_id = merchant_obj.id
      items = @se.items.find_all_by_merchant_id(merchant_id)
      number_of_items_per_merchant << items.count
    end
    number_of_items_per_merchant
  end

  def get_variance_merchants(merchant_items)
    average = average_items_per_merchant
    merchant_items.map do |num|
      (num - average)**2
    end
  end

  def cost_standard_deviation
    all_costs = get_all_costs
    variance = get_variance_item_costs(all_costs)
    sqrt(variance.sum / (all_costs.length - 1).to_f).round(2)
  end

  def get_all_costs
    all_costs = [] # big decimals live here
    @se.items.items.each do |item_obj|
      all_costs << item_obj.unit_price
    end
    all_costs
  end

  def average_all_costs(all_costs)
    (all_costs.sum / all_costs.length).round(2)
  end

  def get_variance_item_costs(all_costs)
    average = average_all_costs(all_costs)
    all_costs.map do |num|
      (num - average)**2
    end
  end

  def merchants_with_high_item_count
    high_item_merchants = []
    target = average_items_per_merchant +
             average_items_per_merchant_standard_deviation
    @se.merchants.merchants.each do |merchant_obj|
      merchant_id = merchant_obj.id
      items = @se.items.find_all_by_merchant_id(merchant_id)
      if items.count >= target
        high_item_merchants << merchant_obj
      end
    end
    high_item_merchants
  end

  def average_item_price_for_merchant(merchant_id)
    all_merchant_items = @se.items.find_all_by_merchant_id(merchant_id)
    all_item_prices = all_merchant_items.map do |item|
      item.unit_price
    end
    (all_item_prices.sum / all_item_prices.count).round(2)
  end

  def average_average_price_per_merchant
    merchant_averages = []
    @se.merchants.merchants.each do |merchant_obj|
      merchant_id = merchant_obj.id
      merchant_averages << average_item_price_for_merchant(merchant_id)
    end
    (merchant_averages.sum / @se.merchants.merchants.count).round(2)
  end

  def average_price_per_item
    total_cost = []
    @se.items.items.each do |item|
      total_cost << item.unit_price
    end
    (total_cost.sum / @se.items.items.count.to_f).round(2)
  end

  def golden_items
    gold_items = []
    target = average_price_per_item +
             (cost_standard_deviation * 2)
    @se.items.items.each do |item|
      if item.unit_price >= target
        gold_items << item
      end
    end
    gold_items
  end

end