class SalesAnalyst
attr_reader :sales_engine, :items, :merchants

  def initialize(sales_engine)
    @sales_engine = sales_engine

    @items = sales_engine.items
    @merchants = sales_engine.merchants
  end

  def total_merchants
    merchants.all.count.to_f
  end

  def total_items
    items.all.count.to_f
  end

  def average_items_per_merchant
    (total_items/total_merchants).round(2)
  end

  def variance_of_average_and_items
    variances = merchants.all.map do |merchant|
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
    low_item_count = merchants.all.map do |merchant|
      if merchant.items.count <= avg - sd
        merchant
      end
    end
    low_item_count.compact
  end

  def average_item_price_for_merchant(merchant_id)
    found_items = items.find_all_by_merchant_id(merchant_id)
    count = found_items.count
    item_total = found_items.reduce(0) do |sum, item|
      item.unit_price + sum
    end
    (item_total/count).round(2)
  end

  def average_price_per_merchant
    all_merchants_average = merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    (all_merchants_average.inject(:+)/total_merchants).round(2)
  end

  def average_price_of_all_items
    items_price_total = items.all.reduce(0) do |sum, item|
      item.unit_price + sum
    end
    (items_price_total/total_items).to_f.round(2)
  end

  def variance_of_all_item_prices_from_mean
    variances = items.all.map do |item|
      (item.unit_price.to_f - average_price_of_all_items) ** 2
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

  def golden_items
    sd = items_standard_deviation
    avg = average_price_of_all_items
    items.all.map { |item| item if item.unit_price >= (avg + (sd*2)) }.compact
  end
end
