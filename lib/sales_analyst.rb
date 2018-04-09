class SalesAnalyst
attr_reader :engine

  def initialize(sales_engine)
    @engine = sales_engine
  end

  def average_items_per_merchant
    items = @engine.items.elements.count.to_f
    merchants = @engine.merchants.elements.count.to_f
    (items / merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    merchants = @engine.merchants.elements
    items = @engine.items
    average = average_items_per_merchant
    deviation_sum = 0
    merchants.keys.each do |merchant_id|
      item_count = items.find_all_by_merchant_id(merchant_id).count
      deviation_sum += (item_count.to_f - average).abs ** 2
    end
    divided_deviation = deviation_sum / (merchants.count - 1)
    Math.sqrt(divided_deviation).round(2)
  end

  def merchants_with_high_item_count
    threshold = average_items_per_merchant +
      (average_items_per_merchant_standard_deviation * 2)
    @engine.merchants.all.find_all do |merchant|
      merch_count = @engine.items.find_all_by_merchant_id(merchant.id).count
      merch_count > threshold
    end
  end

  def average_item_price_for_merchant(merchant_id)
    items = @engine.items.find_all_by_merchant_id(merchant_id)
    total_cost = 0.0
    items.each do |item|
      total_cost += item.unit_price
    end
    (total_cost / items.count).round(2)
  end

  def average_average_price_per_merchant
    merchants = @engine.merchants.all
    total_cost = 0.0
    merchants.each do |merchant|
      total_cost += average_item_price_for_merchant(merchant.id)
    end
    (total_cost / merchants.count).round(2)
  end

  def average_item_cost
    items = @engine.items.all
    total_cost = 0.0
    items.each do |item|
      total_cost += item.unit_price
    end
    (total_cost / items.count).round(2)
  end

  def golden_items
    threshold = average_item_cost +
      (standard_deviation * 2)
    @engine.items.all.find_all do |item|
      item.unit_price > threshold
    end
  end

  def standard_deviation
    items = @engine.items.all
    deviation_sum = 0
    average = average_item_cost
    items.each do |item|
      deviation_sum += (item.unit_price - average).abs ** 2
    end
    divided_deviation = deviation_sum / (items.count - 1)
    Math.sqrt(divided_deviation).round(2).to_f
  end
end
