require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :sales_engine, :items, :merchants

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @items = sales_engine.items.all
    @merchants = sales_engine.merchants.all
  end

  def average_items_per_merchant
    (items.count / merchants.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    avg = average_items_per_merchant
    total_difference = merchants.inject(0) do |sum, merchant|
      merchant_items = sales_engine.items.find_all_by_merchant_id(merchant.id)
      sum += (merchant_items.count - avg)**2
    end
    Math.sqrt(total_difference / (merchants.length - 1)).round(2)
  end

  def merchants_with_high_item_count
    double = average_items_per_merchant_standard_deviation * 2
    merchants.find_all do |merchant|
      # KR refactor opportunity, 33 same as line 19
      sales_engine.items.find_all_by_merchant_id(merchant.id).count > double
    end
  end

  def average_item_price_for_merchant(merchant_id)
    items = sales_engine.items.find_all_by_merchant_id(merchant_id)
    if items.empty?
      BigDecimal(0)
    else
      price = BigDecimal(items.inject(0) do |sum, item|
                           sum + BigDecimal(item.unit_price)
                         end) # average item price)
      (price / items.count).round(2)
    end
  end

  def average_average_price_per_merchant
    total_price = merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end.inject(0, :+)
    (total_price / merchants.count).round(2)
  end

  def golden_items
    prices = items.map { |item| item.unit_price }
    avg = (prices.sum / prices.count).round(2)
    total_diff = prices.inject(0) do |sum, price|
      sum + (price - avg)**2
    end.round(2)
    std_dev = Math.sqrt(total_diff / (prices.length - 1)).round(2)
    items.find_all do |item|
      item.unit_price.to_f >= avg + (std_dev * 2)
    end
  end
end
