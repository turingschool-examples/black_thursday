require_relative './modules/precision_math'

class SalesAnalyst
  include PrecisionMath
  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    item_count = @engine.items.all.size
    merch_count = @engine.merchants.all.size
    (item_count.to_f / merch_count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    counts = @engine.merchants.all.inject([]) do |accumulator, merch|
      accumulator << @engine.items.find_all_by_merchant_id(merch.id).length
    end
    stdev(counts).to_f.round(2)
  end

  def merchants_with_high_item_count
    avg = average_items_per_merchant
    stdev = average_items_per_merchant_standard_deviation
    threshold = avg + stdev
    @engine.merchants.all.find_all do |merchant|
      items = @engine.items.find_all_by_merchant_id(merchant.id)
      items.length > threshold
    end
  end

  def average_item_price_for_merchant(id)
    items = @engine.items.find_all_by_merchant_id(id)
    prices = items.map do |item|
      item.unit_price
    end
    float = average(prices).to_f.round(2)
    BigDecimal.new(float, float.to_s.length)
  end

  def average_average_price_per_merchant
    merchants = @engine.merchants.all
    average_prices = merchants.inject([]) do |averages, merchant|
      averages << average_item_price_for_merchant(merchant.id)
    end
    float = average(average_prices).to_f.round(2)
    BigDecimal.new(float, float.to_s.length)
  end

  def golden_items
    items = @engine.items.all
    item_prices = items.map do |item|
      item.unit_price
    end
    threshold = average(item_prices) + (2 * stdev(item_prices))
    items.find_all do |item|
      item.unit_price > threshold
    end
  end

end
