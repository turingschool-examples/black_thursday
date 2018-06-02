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

  # def average_item_price_for_merchant(merchant_id)
  #   prices = items_grouped_by_merchant_id[merchant_id].map do |item|
  #     item.unit_price
  #   end
  #   (prices.inject(:+)/prices.count).round(2)
  # end

  # def average_item_price_for_merchant(merchant_id) #############################
  #   number_of_items = items_grouped_by_merchant_id[merchant_id].count
  #
  #   total = items_grouped_by_merchant_id[merchant_id].inject(BigDecimal(0)) do |sum, item|
  #     sum += item.unit_price
  #   end
  #   (total/number_of_items).round(2)
  # end

  def average_average_price_per_merchant #######################################
    avg_prices = items_grouped_by_merchant_id.keys.map do |merchant_id|
      average_item_price_for_merchant(merchant_id)
    end
    (avg_prices.inject(:+)/avg_prices.count).round(2)
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
    (all_item_unit_prices.inject(:+)/all_item_unit_prices.count).round(2)
  end

  def price_variance
    mean = average_item_unit_price
    @items.all.map do |item|
      (item.unit_price - mean) ** 2
    end
  end

  def unit_price_std_dev
    sum = price_variance.inject(:+)
    Math.sqrt(sum/(all_item_unit_prices.count-1)).round(2)
  end

  def golden_items #############################################################
    std_dev = unit_price_std_dev
    mean = average_item_unit_price
    two_std_dev = mean + (std_dev * 2)
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
