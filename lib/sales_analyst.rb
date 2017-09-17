class SalesAnalyst
  attr_reader :sales_engine, :items_std_deviation

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @items_std_deviation = nil
  end

  def average_items_per_merchant
    total_items = sales_engine.items.items.count
    total_merchants = sales_engine.merchants.merchants.count
    (total_items.to_f / total_merchants).round(2)
  end

  def find_all_averages_by_merchant
    sales_engine.merchants.merchants.map do |merchant|
      items_for_merchant = sales_engine.find_merchant_items(merchant.id)
      if items_for_merchant.count <= 1
        1
      else
        items_for_merchant.count.round(2)
      end
    end
  end

  def mean
    merchant_item_avgs = find_all_averages_by_merchant
    merchant_item_avgs.reduce(0.0, :+) / merchant_item_avgs.count
  end

  def average_items_per_merchant_standard_deviation
    mean_result = mean
    differences_squared = find_all_averages_by_merchant.map do |num|
      (num - mean_result)**2
    end
    Math.sqrt(differences_squared.sum/(differences_squared.count - 1)).round(2)
  end

  def merchants_with_high_item_count
    top_merch = []
    mean_result = mean
    items_std_deviation = average_items_per_merchant_standard_deviation
    sales_engine.merchants.merchants.each do |merchant|
      merch_item_count = sales_engine.find_merchant_items(merchant.id)
      if merch_item_count.count > (items_std_deviation + mean_result)
        top_merch << merchant
      end
    end
    top_merch
  end

  def average_item_price_for_merchant(merchant_id)
    items_for_merchant = sales_engine.find_merchant_items(merchant_id)
    (items_for_merchant.map do |item|
      item.unit_price
    end.sum / items_for_merchant.count).round(2)
  end

  def average_average_price_per_merchant
    (sales_engine.merchants.merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end.sum / sales_engine.merchants.merchants.count).round(2)
  end

  def average_item_price
    sales_engine.items.items.map do |item|
      item.unit_price
    end.sum / sales_engine.items.items.count
  end

  def std_deviation_of_item_price
    price_avg = average_item_price
    differences_squared = sales_engine.items.items.map do |item|
      (item.unit_price - price_avg)**2
    end
    Math.sqrt(differences_squared.sum/(differences_squared.count - 1)).round(2)
  end

    def golden_items
      golden_items = []
      std_deviation = std_deviation_of_item_price
      sales_engine.items.items.each do |item|
        if item.unit_price > (std_deviation * 2)
          golden_items << item
        end
      end
      golden_items
    end

end
