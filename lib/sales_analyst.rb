require 'pry'

class SalesAnalyst
  attr_reader :sales_engine,
              :items,
              :merchants

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @items = load_items
    @merchants = load_merchants
  end

  def load_items
    sales_engine.load_items
  end

  def load_merchants
    sales_engine.merchants.all
  end

  def average(array)
    array.inject{ |sum, element| sum + element }.to_f / array.count
  end

  def find_standard_deviation(array)
    mean = average(array)
    n = array.length
    sum_squares = array.inject(0) { |sum, element| sum + (mean - element)**2 }
    Math.sqrt(sum_squares / (n-1))
  end

  def average_items_per_merchant
    items_count      = sales_engine.items.all.count
    merchants_count  = sales_engine.merchants.all.count
    average          = items_count.to_f / merchants_count.to_f
    average.round(2)
  end

  def average_items_per_merchant_standard_deviation
    items_per_merchant = []
    @merchants.each do |merchant_instance|
      items_per_merchant << merchant_instance.items.count
    end
    result = find_standard_deviation(items_per_merchant)
    return result.round(2)
  end

  def merchants_with_high_item_count
    std_dev = average_items_per_merchant_standard_deviation
    threshold = std_dev + average_items_per_merchant
    array = @merchants.find_all do |merchant|
        merchant.items.count > threshold
      end
      # name = array.map { |merchant| merchant.name }
      # ^if spec harness breaks delete this line^
  end

  def average_item_price_for_merchant(id)
    prices = @items[id].map { |item| item.unit_price.to_f }
    return BigDecimal.new(average(prices).to_f, 5).round(2)
  end

  def average_average_price_per_merchant
    # need to find another way to get array of merchant ids
    prices = @items.keys.map do |id|
      average_item_price_for_merchant(id)
    end
    # binding.pry
    average_price = average(prices)
    return BigDecimal.new(average_price, 6).floor(2)
  end

  def get_item_average_price
    item_prices = []
    item_prices = sales_engine.items.all.map do |item|
      item.unit_price
    end
    average(item_prices)
  end

  def get_item_standard_deviation
    item_prices = []
    item_prices = sales_engine.items.all.map do |item|
      item.unit_price
    end
    find_standard_deviation(item_prices)
  end

  def golden_items
    ave = get_item_average_price
    std_dev = get_item_standard_deviation
    threshold = BigDecimal(ave + std_dev, 4)
    golden_items = @sales_engine.items.all do |item|
      # binding.pry
        item.unit_price > threshold
      end
      golden_items

  end
end
