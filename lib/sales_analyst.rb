require_relative 'math_methods'

class SalesAnalyst
  include MathMethods
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    amount_of_items = @sales_engine.items.collection.length
    amount_of_merchants = @sales_engine.merchants.collection.length
    average(amount_of_items, amount_of_merchants)
  end

  def average_items_per_merchant_standard_deviation
    values = difference_between_number_and_mean_squared
    total = sum(values) / (values.length - 1)
    Math.sqrt(total).round(2)
  end

  def each_merchants_total_items
    total_items_list = @sales_engine.merchants.collection.values.map do |merchant|
      single_merchants_total_items(merchant.id)
    end
  end

  def difference_between_number_and_mean_squared
    each_merchants_total_items.map do |value|
      (value - average_items_per_merchant)**2
    end
  end

  def sum(numbers)
    numbers.reduce(0) do |collector, number|
      collector += number
      collector
    end
  end

  def single_merchants_total_items(desired_id)
    single_merchants_items(desired_id).length
  end

  def merchant_with_high_item_count
    deviation_above = average_items_per_merchant + average_items_per_merchant_standard_deviation
    @sales_engine.merchants.collection.keys.inject([]) do |collector, merchant|
      if single_merchants_total_items(merchant) >= deviation_above
      collector << @sales_engine.merchants.collection[merchant]
      end
      collector
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant_items = single_merchants_total_items(merchant_id)
    item_price_total = sum(item_prices_for_merchant(merchant_id))
    BigDecimal((item_price_total / merchant_items).round(2))
  end


  def item_prices_for_merchant(merchant_id)
    single_merchants_items(merchant_id).inject([]) do |collector, item|
      collector << item.unit_price
      collector
    end
  end

  def single_merchants_items(desired_id)
    @sales_engine.items.collection.values.find_all do |item|
      if item.merchant_id == desired_id
        item
      end
    end
  end


end
