class SalesAnalyst
attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def total_merchants
    sales_engine.merchants.all.count.to_f
  end

  def total_items
    sales_engine.items.all.count.to_f
  end

  def average_items_per_merchant
    (total_items/total_merchants).round(2)
  end

  def variance_of_average_and_items
    merchants = sales_engine.merchants.all
    variances = []
    merchants.each do |merchant|
      variances <<
      (merchant.items.count - average_items_per_merchant) **2
    end
    variances.inject(:+)
  end

  def variance_divided_merchants
    variances = variance_of_average_and_items
    variances/(total_merchants - 1)
  end

  def average_items_per_merchant_standard_deviation
    Math.sqrt(variance_divided_merchants).round(2)
  end

  def merchants_with_low_item_count
    sd = average_items_per_merchant_standard_deviation
    avg = average_items_per_merchant
    low_item_count = []
    sales_engine.merchants.all.each do |merchant|
      if merchant.items.count <= avg - sd
        low_item_count << merchant
      end
    end
    low_item_count
  end

  def average_item_price_for_merchant(merchant_id)
    items = sales_engine.items.find_all_by_merchant_id(merchant_id)
    count = items.count
    item_total = items.reduce(0) do |sum, item|
      item.unit_price + sum
    end
    (item_total/count).round(2)
  end

  def average_price_per_merchant
    all_merchants_average = []
    merchants = sales_engine.merchants.all
    merchants.each do |merchant|
      averages = average_item_price_for_merchant(merchant.id)
      all_merchants_average << averages
    end
    (all_merchants_average.inject(:+)/total_merchants).round(2)
  end

  def average_price_of_all_items
    items = sales_engine.items.all
    items_price_total = items.reduce(0) do |sum, item|
      item.unit_price + sum
    end
    (items_price_total/total_items).to_f.round(2)
  end

  def variance_of_all_item_prices_from_mean
    items = sales_engine.items.all
    variances = []
    items.each do |item|
      variances << (item.unit_price.to_f - average_price_of_all_items) ** 2
  end
    variances.inject(:+).round(2)
  end

  def variance_divide_total_items
    variance = variance_of_all_item_prices_from_mean
    (variance/(total_items - 1)).round(2)
  end

  def items_standard_deviation
    Math.sqrt(variance_divide_total_items).round(2)
  end

end
