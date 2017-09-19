module ItemCountAnalyst

  def average_items_per_merchant
    merchant_count = engine.merchant_list.count
    item_count = engine.item_list.count
    average = item_count.to_f / merchant_count
    average.round(2)
  end

  def sum_of_square_differences_item_count(merchants, mean)
    merchants.reduce(0) do |result, merchant|
      difference_squared = (mean - merchant.items.count) ** 2
      result + difference_squared
    end
  end

  def average_items_per_merchant_standard_deviation
    merchants = engine.merchant_list
    mean = average_items_per_merchant
    sum = sum_of_square_differences_item_count(merchants, mean)
    sample_variance = find_sample_variance(merchants, sum)
    standard_deviation(sample_variance)
  end

  def merchants_with_high_item_count
    mean = average_items_per_merchant
    standard_deviation = average_items_per_merchant_standard_deviation
    merchants = @engine.merchant_list
    merchants.find_all do |merchant|
      merchant.items.count > standard_deviation_above(mean, standard_deviation)
    end
  end


end
