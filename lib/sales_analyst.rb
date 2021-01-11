class SalesAnalyst
  attr_reader :parent

  def initialize(parent)
    @parent = parent
  end

  def average_items_per_merchant
    (all_items_count / all_merchants_count.to_f).round(2)
  end

  def all_items_count
    @parent.items.all.length
  end

  def all_merchants_count
    @parent.merchants.all.length
  end

  def generate_merchant_ids
    @parent.merchants.all.map do |merchant|
      merchant.id
    end
  end

  def items_count_per_merchant
    generate_merchant_ids.map do |id|
      @parent.items.find_all_by_merchant_id(id).count
    end
  end

  def all_items_minus_one
    items_count_per_merchant.length - 1
  end

  def standard_deviaton_calculation(total, collection_minus_one)
    standard_deviaton = Math.sqrt(total / collection_minus_one)
    standard_deviaton.round(2)
  end

  def average_items_per_merchant_standard_deviation
    total = items_count_per_merchant.reduce(0) do |acc, item_number|
      acc += ((item_number - average_items_per_merchant) ** 2)
    end
    standard_deviaton_calculation(total, all_items_minus_one)
  end

  def merchants_with_high_item_count
    high_seller_count = average_items_per_merchant + average_items_per_merchant_standard_deviation
    merchants = []
    generate_merchant_ids.find_all do |id|
      item_count = @parent.items.find_all_by_merchant_id(id).count
      merchants.push(@parent.merchants.find_by_id(id)) if item_count > high_seller_count
    end
    merchants
  end

  def average_item_price_for_merchant(id)
    item_count = @parent.items.find_all_by_merchant_id(id).count
    all_items_price = @parent.items.find_all_by_merchant_id(id).sum do |item|
      item.unit_price
    end
    average_price = all_items_price / item_count.to_f
    average_price.round(2)
  end

  def average_average_price_per_merchant
    all_merchants_price_averages = generate_merchant_ids.sum do |id|
      average_item_price_for_merchant(id)
    end
    all_merchants_average = all_merchants_price_averages / all_merchants_count
    all_merchants_average.round(2)
  end

  def mean_prices_per_merchant
    mean_prices_per_merchant = generate_merchant_ids.map do |id|
      average_item_price_for_merchant(id)
    end
  end

  def golden_items
    # mean_prices_per_merchant = generate_merchant_ids.map do |id|
    #   average_item_price_for_merchant(id)
    # end
    mean_average_across_all_merchants = average_average_price_per_merchant
    all_means_minus_one = (mean_prices_per_merchant.length) - 1
    total = mean_prices_per_merchant.reduce(0) do |total, price|
      total += ((price - mean_average_across_all_merchants) ** 2)
    end
    format_price_deviation = standard_deviaton_calculation(total, all_means_minus_one)
    two_standard_deviations_plus_average = (average_average_price_per_merchant * 3) + format_price_deviation
    expensive_items = @parent.items.all.find_all do |item|
      item.unit_price > two_standard_deviations_plus_average
    end
    expensive_items
  end
end
