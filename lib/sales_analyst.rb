require 'pry'

class SalesAnalyst
  # attr_reader :engine

  def initialize(engine)
    @engine = engine
    @items = @engine.items
    @merchants = @engine.merchants
    @invoices = @engine.invoices
  end

  def average_items_per_merchant ###############################################
    mean(item_count_for_each_merchant_id.values)
  end

  def average_items_per_merchant_standard_deviation ############################
    standard_deviation(item_count_for_each_merchant_id.values)
  end

  def merchants_with_high_item_count ###########################################
    one_std_dev =
      average_items_per_merchant + average_items_per_merchant_standard_deviation
    item_count_for_each_merchant_id.map do |merchant_id,item_count|
      @merchants.find_by_id(merchant_id) if item_count > one_std_dev
    end.compact
  end

  def average_item_price_for_merchant(merchant_id) #############################
    prices = items_grouped_by_merchant_id[merchant_id].map do |item|
      item.unit_price
    end
    mean(prices)
  end

  def average_average_price_per_merchant #######################################
    avg_prices = items_grouped_by_merchant_id.map do |merchant_id, items|
      average_item_price_for_merchant(merchant_id)
    end
    mean(avg_prices)
  end

  def items_grouped_by_merchant_id
    @items.all.group_by do |item|
      item.merchant_id
    end
  end

  def item_count_for_each_merchant_id
    items_grouped_by_merchant_id.merge(items_grouped_by_merchant_id) do |merchant_id,item_list|
      item_list.count
    end
  end

  def mean(numbers_array)
    (numbers_array.inject(:+).to_f / numbers_array.count).round(2)
  end

  def summed_variance(numbers_array)
    avg = mean(numbers_array)
    numbers_array.map do |count|
      (count - avg) ** 2
    end.inject(:+)
  end

  def standard_deviation(numbers_array)
    result = (summed_variance(numbers_array) / (numbers_array.count - 1))
    Math.sqrt(result).round(2)
  end

  def all_item_unit_prices
    @items.all.map do |item|
      item.unit_price
    end
  end

  def average_item_unit_price
    mean(all_item_unit_prices)
  end

  def average_item_unit_price_standard_deviation
    standard_deviation(all_item_unit_prices)
  end

  def golden_items #############################################################
    two_std_dev =
      average_item_unit_price + (average_item_unit_price_standard_deviation * 2)
    @items.all.map do |item|
      item if item.unit_price > two_std_dev
    end.compact
  end

  def average_invoices_per_merchant ############################################
    (@invoices.all.count/@merchants.all.count.to_f).round(2)
  end

  # def average_invoices_per_merchant_standard_deviation
  # end
end
