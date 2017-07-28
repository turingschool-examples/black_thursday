module Stats

  def average(info)
    (info.reduce(:+)/info.count.to_f).round(2)
  end

  def variance(info)
    current_av = average(info)
    info.map {|num| (current_av-num)**2}
  end

  def standard_deviation(info)
    average = average(info)
    variance = variance(info)
    Math.sqrt(average(variance)).round(2)
  end

  def one_standard_deviation_bar
    avg     = average_items_per_merchant
    std_dev = average_items_per_merchant_standard_deviation
    avg + std_dev
  end

  def num_items_per_merchant
    se.all_merchants.map do |merchant|
      merch = se.merchants.find_by_id(merchant.id)
      merch.items.count
    end
  end

  def high_selling_merchants
    se.all_merchants.zip(num_items_per_merchant)
  end

  def merchant_items_prices(id)
    merchant = se.merchants.find_by_id(id)
    merchant.items.map {|item| item.unit_price}
  end

  def merchant_id_item_group
    se.all_items.group_by {|item| item.merchant_id}
  end

end
