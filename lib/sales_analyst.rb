require 'bigdecimal'

class SalesAnalyst

  def initialize(merchant_repository, item_repository)
    @merchant_repository = merchant_repository
    @item_repository     = item_repository
  end

  def average_items_per_merchant
    @item_repository.average_items_per_merchant
  end

  def average_items_per_merchant_standard_deviation
    mean_total_sqr = @item_repository.group_item_by_merchant_id
    mean_items_per = average_items_per_merchant

    (Math.sqrt(get_mean_of_totaled_squares(mean_total_sqr, mean_items_per))).round(2)
  end

  def get_squared_item_prices
    @item_repository.items.map do |item|
      (item.unit_price - @item_repository.mean_item_price) ** 2
    end
  end

  def get_mean_of_items_squared
    sum = get_squared_item_prices.inject(0) do |total, price|
      total += price
    end
    sum / get_squared_item_prices.count
  end

  def average_price_per_item_standard_deviation
    (Math.sqrt( get_mean_of_items_squared )).round(2)
  end

  def golden_items
    mean  = @item_repository.mean_item_price
    stdev = average_price_per_item_standard_deviation * 2
    @item_repository.items.find_all do |item|
      item.unit_price > (mean + stdev)
    end
  end

  def merchants_with_high_item_count
    stdev   = average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    hash    = @item_repository.group_item_by_merchant_id
    array   = []
    hash.each do |id, items|
      if items.count > (stdev + average)
        array << @merchant_repository.find_by_id(id)
      end
    end
    array
  end

  def average_item_price_for_merchant(id)
    @item_repository.average_item_price_for_merchant(id)
  end

  def average_average_price_per_merchant
    @item_repository.average_average_price_per_merchant
  end


  def get_mean_of_totaled_squares(grouped_hash, average)
    get_total_of_squares(grouped_hash, average) / get_squared_values(grouped_hash, average).count
  end

  def get_total_of_squares(grouped_hash, average)
    get_squared_values(grouped_hash, average).inject(0) {|sum, value| sum += value}
  end

  def get_squared_values(grouped_hash, average)
   grouped_hash.map do |id, item|
      (item.count - average) ** 2
    end
  end
end
