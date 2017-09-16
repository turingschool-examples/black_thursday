
class SalesAnalyst

  def initialize(engine)
    @engine = engine

  end

  def average_items_per_merchant
    (@engine.items.all.count.to_f / @engine.merchants.all.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    item_counts = get_item_count_from_merchants
    squared = square_counts(item_counts)
    sum = squared.inject(:+)
    divided = sum / (@engine.merchants.all.count - 1)
    Math.sqrt(divided).round(2)
  end

  def get_item_count_from_merchants
    @engine.merchants.all.map do |merchant|
      merchant.items.count
    end
  end

  def square_counts(item_counts)
    squared = item_counts.map do |count|
      (count - average_items_per_merchant) ** 2
    end
  end

  def merchants_with_high_item_count
    bar = average_items_per_merchant + average_items_per_merchant_standard_deviation
    @engine.merchants.all.find_all do |merchant|
      merchant.items.count > bar
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = @engine.merchants.find_by_id(merchant_id)
    sum = merchant.items.inject(0) do |total, item|
      total += item.unit_price/100
    end
    (sum / merchant.items.count * 100).round(2)
  end

  def average_average_price_per_merchant
    average_prices = @engine.merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end

    (average_prices.reduce(:+) / @engine.merchants.all.count).truncate(2)
  end

  def average_item_price
    prices = @engine.items.items.map do |item|
      item.unit_price
    end
    prices.inject(:+) / @engine.items.items.count
  end

  def item_price_standard_deviation
    squared = @engine.items.items.map do |item|
      (item.unit_price - average_item_price) ** 2
    end
    divided = squared.inject(:+) / (@engine.items.items.count - 1)
    Math.sqrt(divided)
    # TODO this is where it converts check decimal count
  end

  def golden_items
    bar = (2 * item_price_standard_deviation) + average_item_price
    @engine.items.items.find_all do |item|
      item.unit_price > bar
    end
  end
  #
  def average_invoices_per_merchant
    @engine.invoices.all.count.to_f / @engine.merchants.all.count.to_f
  end

  def average_invoices_per_merchant_standard_deviation
    squared  = @engine.merchants.all.map do |merchant|
      (merchant.invoices.count - average_invoices_per_merchant) ** 2
    end
    divided = squared.inject(:+) / (@engine.merchants.merchants.count - 1)
    Math.sqrt(divided)
  end





end
