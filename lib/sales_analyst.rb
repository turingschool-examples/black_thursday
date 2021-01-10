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
    @parent.merchants.merchants.map do |merchant|
      merchant.id
    end
  end

  def average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant
    items_per_merchant = generate_merchant_ids.map do |id|
      @parent.items.find_all_by_merchant_id(id).count
    end

    all_items_minus_one = (items_per_merchant.length) - 1

    total = 0
    items_per_merchant.each do |item_number|
      total += ((item_number - mean) ** 2)
    end

    standard_deviaton = Math.sqrt(total / all_items_minus_one)
    standard_deviaton.round(2)
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

  def golden_items
    # mean = average_items_per_merchant
    # items_per_merchant = generate_merchant_ids.map do |id|
    #   @parent.items.find_all_by_merchant_id(id).count
    # end

    mean_price_per_merchant = generate_merchant_ids.map do |id|
      average_item_price_for_merchant(id)
    end

    mean_average_across_all_merchants = average_average_price_per_merchant

    all_means_minus_one = (mean_price.length) - 1

    total = 0
    mean_price_per_merchant.each do |price|
      total += ((price - mean_average_across_all_merchants) ** 2)
    end

    standard_price_deviaton = Math.sqrt(total / all_items_minus_one)
    standard_price_deviaton.round(2)

    require "pry"; binding.pry
    # all the item prices boolean logic to check for each price to be double deviation
    # push the item to an array

  end
end