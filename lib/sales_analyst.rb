class SalesAnalyst

  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    (engine.items.all.count.to_f / engine.merchants.all.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    sos = engine.merchants.all.reduce(0) do |sum, merchant|
      sum + (merchant.items.count - average_items_per_merchant)**2
    end
    variance = sos / (engine.merchants.all.count - 1)
    (Math.sqrt(variance)).round(2)
  end

  def merchants_with_high_item_count
    std_dev = average_items_per_merchant_standard_deviation
    engine.merchants.all.find_all do |merchant|
      (merchant.items.count - average_items_per_merchant) > std_dev
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = engine.merchants.find_by_id(merchant_id)
    total_price = merchant.items.reduce(0) do |sum, item|
      sum + item.unit_price
    end
    return 0 if merchant.items.empty?
    (total_price / merchant.items.count).round(2)
  end

  def average_average_price_per_merchant
    total_average = engine.merchants.all.reduce(0) do |sum, merchant|
      sum + average_item_price_for_merchant(merchant.id)
    end
    (total_average / engine.merchants.all.count).round(2)
  end

  def average_item_price
    total_items = engine.items.all.count
    total_price = engine.items.all.reduce(0) do |sum, item|
      sum + item.unit_price
    end
    (total_price / total_items).round(2)
  end

  def average_item_price_standard_deviation
    sos = engine.items.all.reduce(0) do |sum, item|
      sum + (item.unit_price - average_item_price)**2
    end
    variance = sos / (engine.items.all.count - 1)
    (Math.sqrt(variance)).round(2)
  end

  def golden_items
    std_dev = average_item_price_standard_deviation
    engine.items.all.find_all do |item|
      (item.unit_price - average_average_price_per_merchant) > (2 * std_dev)
    end
  end
end
