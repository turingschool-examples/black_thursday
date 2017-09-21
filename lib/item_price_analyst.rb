module ItemPriceAnalyst

  def average_item_price_for_merchant(merchant_id)
    item_repo = @engine.items
    items = item_repo.find_all_by_merchant_id(merchant_id)
    item_prices = items.map {|item| item.unit_price}
      if item_prices.empty?
        return 0
      else
        avg_price = BigDecimal(item_prices.sum / item_prices.count)
        avg_price.round(2)
      end
  end

  def average_average_price_per_merchant
    merchant_repo = @engine.merchants
    merchants = merchant_repo.merchants
    merchant_averages = merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    average = merchant_averages.sum / merchant_averages.count.to_f
    BigDecimal(average).truncate(2)
  end

  def sum_of_square_differences_item_price(items, mean)
    items.reduce(0) do |result, item|
      difference_squared = (mean - item.unit_price) ** 2
      result + difference_squared
    end
  end

  def average_item_price_standard_deviation
    items = @engine.item_list
    mean = average_average_price_per_merchant
    sum = sum_of_square_differences_item_price(items, mean)
    sample_variance = find_sample_variance(items, sum)
    standard_deviation(sample_variance)
  end

  def golden_items
    standard_deviation = average_item_price_standard_deviation
    all_items = @engine.item_list
    mean = average_average_price_per_merchant
    all_items.find_all do |item|
      item.unit_price > standard_deviation_above(mean, standard_deviation, 2)
    end
  end

end
