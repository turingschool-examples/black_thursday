class SalesAnalyst

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    items     = sales_engine.items.all.count.to_f
    merchants = sales_engine.merchants.all.count.to_f
    (items / merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    numerator   = items_per_merchant_std_dev_numerator
    denominator = items_per_merchant_std_dev_denominator
    Math.sqrt(numerator / denominator).round(2)
  end

  def items_per_merchant_std_dev_numerator
    sales_engine.merchants.all.map do |merchant|
      ((merchant.items.count - average_items_per_merchant) ** 2).to_f
    end.reduce(:+).to_f
  end

  def items_per_merchant_std_dev_denominator
    (sales_engine.merchants.all.count - 1).to_f
  end

  def merchants_with_high_item_count
    mean    = average_items_per_merchant
    std_dev = average_items_per_merchant_standard_deviation
    sales_engine.merchants.all.find_all do |merchant|
      merchant.items.count > (mean + std_dev)
    end
  end

  def average_item_price_for_merchant(id)
    items  = sales_engine.merchants.find_by_id(id).items
    return 0 if items.empty?
    prices = items.map do |row|
      row.unit_price
    end.reduce(:+) / items.count
    prices.round(2)
  end

  def average_average_price_per_merchant
    merchants = sales_engine.merchants.all
    sum       = merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end.reduce(:+)
    (sum / merchants.count).round(2)
  end

  def golden_items
    mean    = average_item_price
    std_dev = item_price_standard_deviation
    items   = sales_engine.items.all
    items.find_all do |item|
      item.unit_price > (mean + (std_dev * 2))
    end
  end

  def average_item_price
    items = sales_engine.items.all
    sum   = items.map { |item| item.unit_price }.reduce(:+)
    sum / items.count
  end

  def item_price_standard_deviation
    numerator   = item_price_std_dev_numerator
    denominator = item_price_std_dev_denominator
    Math.sqrt(numerator / denominator).round(2)
  end

  def item_price_std_dev_numerator
    items = sales_engine.items.all
    items.map do |item|
      (item.unit_price - average_item_price) ** 2
    end.reduce(:+)
  end

  def item_price_std_dev_denominator
    sales_engine.items.all.count - 1
  end



end
