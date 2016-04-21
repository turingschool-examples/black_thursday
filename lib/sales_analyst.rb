class SalesAnalyst
  attr_reader :merchants, :items, :se

  def initialize(se)
    @se = se
    @merchants = se.merchants
    @items = se.items
  end

  def items_per_merchant
    merchants.all.map do |merchant|
      merchant.items.count
    end
  end

  def average_items_per_merchant
    (items_per_merchant.reduce(:+)/items_per_merchant.length.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    ipm = items_per_merchant
    av = average_items_per_merchant
    sqdiff = ipm.map do |num|
      (num - av) ** 2
    end
    Math.sqrt(sqdiff.reduce(:+) / (ipm.length - 1)).round(2)
  end

  def merchants_with_high_item_count
    ave_std_dev = average_items_per_merchant_standard_deviation + average_items_per_merchant
    merchants_with_item_counts.map do |merchant|
      merchant[1] > ave_std_dev ? merchant[0] : []
    end.flatten
  end

  def merchants_with_item_counts
    merchants.all.map do |merchant|
      [merchant, merchant.items.count]
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant_items = merchants.find_by_id(merchant_id).items
    rounding = merchant_items.reduce(0) do |sum, item|
      sum + item.unit_price
    end / merchant_items.length
    rounding.round(2)
  end

  def average_average_price_per_merchant
    rounding = merchants.all.reduce(0) do |sum, merchant|
      sum + average_item_price_for_merchant(merchant.id)
    end / merchants.all.length
    rounding.round(2)
  end

  def all_items_unit_prices
    items.all.map do |item|
      item.unit_price
    end
  end

  def average_items_price
    all_items_unit_prices.reduce(:+)/all_items_unit_prices.length
  end

  def items_price_standard_deviation
    all = all_items_unit_prices
    av = average_items_price
    sqdiff = all.map do |num|
      (num - av) ** 2
    end
    Math.sqrt(sqdiff.reduce(:+) / (all.length - 1)).round(2)
  end

  def golden_items
    isd = items_price_standard_deviation
    items.all.find_all do |item|
      item.unit_price > isd * 2
    end
  end


end
