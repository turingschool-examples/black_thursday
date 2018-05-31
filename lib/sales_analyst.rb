require 'pry'

class SalesAnalyst
  # attr_reader :engine

  def initialize(engine)
    @engine = engine
    @items = @engine.items.all
    @merchants = @engine.merchants.all
    @invoices = @engine.invoices.all
  end

  def average_items_per_merchant
    (@items.count/@merchants.count.to_f).round(2)
  end

  def items_by_merchant_id
    @items.group_by do |item|
      item.merchant_id
    end
  end

  def item_count_by_merchant_id
    items_by_merchant_id.map do |merchant_id,item_list|
      item_list.count
    end
  end

  def item_count_variance
    mean = average_items_per_merchant
    item_count_by_merchant_id.map do |count|
      (count - mean) ** 2
    end
  end

  def sum_of_variance
    item_count_variance.inject(:+)
  end

  def average_items_per_merchant_standard_deviation
    Math.sqrt(sum_of_variance/(item_count_by_merchant_id.count-1)).round(2)
  end

  def merchants_with_high_item_count
    std_dev = average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant
    one_std_dev = mean + std_dev
    items_by_merchant_id.map do |id,item_list|
      @engine.merchants.find_by_id(id) if item_list.count > one_std_dev
    end.compact
  end

  def average_item_price_for_merchant(merchant_id)
    prices = items_by_merchant_id[merchant_id].map do |item|
      item.unit_price
    end
    (prices.inject(:+)/prices.count).round(2)
  end

  def average_average_price_per_merchant
    avg_prices = items_by_merchant_id.keys.map do |merchant_id|
      average_item_price_for_merchant(merchant_id)
    end
    (avg_prices.inject(:+)/avg_prices.count).round(2)
  end

  def all_item_unit_prices
    @items.map do |item|
      item.unit_price
    end
  end

  def average_item_unit_price
    (all_item_unit_prices.inject(:+)/all_item_unit_prices.count).round(2)
  end

  def price_variance
    mean = average_item_unit_price
    @items.map do |item|
      (item.unit_price - mean) ** 2
    end
  end

  def unit_price_std_dev
    sum = price_variance.inject(:+)
    Math.sqrt(sum/(all_item_unit_prices.count-1)).round(2)
  end

  def golden_items
    std_dev = unit_price_std_dev
    mean = average_item_unit_price
    two_std_dev = mean + (std_dev * 2)
    @items.map do |item|
      item if item.unit_price > two_std_dev
    end.compact
  end

  def average_invoices_per_merchant
    (@invoices.count/@merchants.count.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    
  end


end
