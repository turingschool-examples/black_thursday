# Merchant Analytics module for compartmentalizing merchant analysis methods
module MerchantAnalytics
  def average_items_per_merchant
    average(number_of(:items), number_of(:merchants)).to_f
  end

  def average_items_per_merchant_standard_deviation
    items = number_of_items_per_merchant.values
    standard_deviation(items, average_items_per_merchant)
  end

  def merchants_with_high_item_count
    threshold = average_items_per_merchant_plus_one_standard_deviation
    number_of_items_per_merchant.map do |id, num_of_items|
      @merchant_repo.find_by_id(id) if num_of_items >= threshold
    end.compact
  end

  def average_item_price_for_merchant(merchant_id)
    average(sum_of_item_price_for_merchant(merchant_id),
            number_of_items_per_merchant[merchant_id])
  end

  def average_average_price_per_merchant
    all_averages = @merchant_repo.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    average(all_averages.inject(:+), number_of(:merchants))
  end

  def top_merchants_by_invoice_count
    plus2_std_dev = average_invoices_per_merchant_plus_two_standard_deviations
    top_merchant_ids = merchants_per_count.map do |count, merchant_ids|
      merchant_ids if count >= plus2_std_dev
    end.flatten.compact

    top_merchant_ids.map do |merchant_id|
      @merchant_repo.find_by_id(merchant_id)
    end
  end

  def bottom_merchants_by_invoice_count
    minus2_std_dev = average_invoices_per_merchant_minus_two_standard_deviations
    bottom_merchant_ids = merchants_per_count.map do |count, merchant_ids|
      merchant_ids if count <= minus2_std_dev
    end.flatten.compact

    bottom_merchant_ids.map do |merchant_id|
      @merchant_repo.find_by_id(merchant_id)
    end
  end
end
