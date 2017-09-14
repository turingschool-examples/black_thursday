require_relative 'sales_engine'

class SalesAnalyst

  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def total_item_count_per_merchant(merchant_repo)
    merchants = merchant_repo.merchants
    merchants.reduce(0) do |item_count, merchant|
      item_count + merchant.items.count
    end
  end

  def average_items_per_merchant
    merchant_repo = @engine.merchants
    merchant_count = merchant_repo.merchants.count
    total_items = total_item_count_per_merchant(merchant_repo)
    total_items.to_f / merchant_count.to_f
  end

  def sum_of_square_differences(merchant_repo, mean)
    merchants = merchant_repo.merchants
    merchants.reduce(0) do |result, merchant|
      difference_squared = (mean - merchant.items.count) ** 2
      result + difference_squared
    end
  end

  def find_sample_variance(merchant_repo, mean)
    sum = sum_of_square_differences(merchant_repo, mean)
    sum / (merchant_repo.merchants.count-1)
  end

  def average_items_per_merchant_standard_deviation
    merchant_repo = @engine.merchants
    mean = average_items_per_merchant
    sample_variance = find_sample_variance(merchant_repo, mean)
    Math.sqrt(sample_variance)
  end

  def merchants_with_high_item_count
    standard_deviation = average_items_per_merchant_standard_deviation
    merchant_repo = @engine.merchants
    merchants = merchant_repo.merchants
    merchants.find_all {|merchant| merchant.items.count > standard_deviation + 1}
  end

  def average_item_price_for_merchant(merchant_id)
    item_repo = @engine.items
    items = item_repo.find_all_by_merchant_id(merchant_id)
    item_prices = items.map {|item| item.unit_price}

    if item_prices.empty?
      return 0
    else
      BigDecimal(item_prices.sum / item_prices.count).round(2)
    end
  end

  def average_average_price_per_merchant
    merchant_repo = @engine.merchants
    merchants = merchant_repo.merchants
    merchant_averages = merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    BigDecimal(merchant_averages.sum / merchant_averages.count).round(2)
  end
  
  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

end
