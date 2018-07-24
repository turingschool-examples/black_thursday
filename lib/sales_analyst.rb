require 'bigdecimal'

class SalesAnalyst

  def initialize(merchant_repository, item_repository)
    @merchant_repository = merchant_repository
    @item_repository     = item_repository
  end

  def average_items_per_merchant
    (get_number_of_items / get_number_of_merchants.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    (Math.sqrt( get_mean_of_totaled_squares )).round(2)
  end

  def mean_item_price
    sum   = 0
    count = 0
    @item_repository.items.each do |item|
      sum += item.unit_price
      count += 1
    end
    sum / count
  end

  def get_squared_item_prices
    @item_repository.items.map do |item|
      (item.unit_price - mean_item_price) ** 2
    end
  end

  def get_mean_of_items_squared
    sum = 0
    get_squared_item_prices.each do |price|
      sum += price
    end
    sum / get_squared_item_prices.count
  end

  def average_price_per_item_standard_deviation
    (Math.sqrt( get_mean_of_items_squared )).round(2)
  end

  def golden_items
    mean  = mean_item_price
    stdev = average_price_per_item_standard_deviation * 2
    @item_repository.items.find_all do |item|
      item.unit_price > (mean + stdev)
    end
  end

  def merchants_with_high_item_count
    stdev   = average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    hash    = group_item_by_merchant_id
    array   = []
    hash.each do |id, items|
      if items.count > (stdev + average)
        array << @merchant_repository.find_by_id(id)
      end
    end
    array
  end

  def average_item_price_for_merchant(id)
    sum      = BigDecimal.new(0)
    merchant = group_item_by_merchant_id.find do |key, items|
      key == id
    end
    merchant[1].each do |item|
      sum += item.unit_price
    end
    average = sum / BigDecimal.new(merchant[1].count)
    average.round(2)
  end

  def average_average_price_per_merchant
    sum   = BigDecimal.new(0)
    hash  = group_item_by_merchant_id
    total_merchants = 0
    hash.each do |id, items|
      sum += average_item_price_for_merchant(id)
      total_merchants += 1
    end
    average = sum / BigDecimal.new(total_merchants)
    average.round(2)
  end

  def get_mean_of_totaled_squares
    get_total_of_squares / get_squared_values.count
  end

  def get_total_of_squares
    get_squared_values.inject(0) {|sum, value| sum += value}
  end

  def get_squared_values
    group_item_by_merchant_id.map do |id, item|
      (item.count - average_items_per_merchant) ** 2
    end
  end

  def get_number_of_merchants
    @merchant_repository.merchants.count
  end

  def get_number_of_items
    @item_repository.items.count
  end

  def group_item_by_merchant_id
    @item_repository.items.group_by { |item| item.merchant_id}
  end

end
