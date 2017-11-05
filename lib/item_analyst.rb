require_relative './statistics'

module ItemAnalyst
  include Statistics

  def average_items_per_merchant
    averager(item_count, merchant_count)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(
      all_items_for_each_merchant,
      item_count,
      merchant_count
    )
  end

  def merchants_with_high_item_count
    minimum = minimum_for_high_items
    accumulate_merchant_items.reduce([]) do |result, (merchant_id, items)|
      result << se.merchants.find_by_id(merchant_id) if items >= minimum
      result
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = se.merchants.find_by_id(merchant_id.to_s)
    BigDecimal((merchant.items.inject(0) do |sum, item|
      sum += item.unit_price
    end/merchant.items.count)).round(2)
  end

  def average_average_price_per_merchant
    BigDecimal((se.merchants.merchants.inject(0) do |sum, merchant|
      sum += average_item_price_for_merchant(merchant.id)
    end/merchant_count)).round(2)
  end

  def golden_items
    minimum = minimum_for_golden_item
    find_golden_items(minimum)
  end

  def standard_deviation_of_item_price
    standard_deviation(
      all_item_prices,
      total_all_item_prices,
      item_count
    )
  end

  private
  def all_items_for_each_merchant
    accumulate_merchant_items.flat_map do |merchant_items|
      merchant_items[1]
    end
  end

  def accumulate_merchant_items
    se.items.items.reduce({}) do |result, item|
      result[item.merchant_id] = 0 if result[item.merchant_id].nil?
      result[item.merchant_id] += 1
      result
    end
  end

  def minimum_for_high_items
    average_items_per_merchant + average_items_per_merchant_standard_deviation
  end

  def all_item_prices
    se.items.items.map do |item|
      item.unit_price
    end
  end

  def total_all_item_prices
    se.items.items.inject(0) do |sum, item|
      sum += item.unit_price
    end
  end

  def average_item_price
    BigDecimal(averager(total_all_item_prices, item_count).round)
  end

  def minimum_for_golden_item
    average_item_price + (2 * standard_deviation_of_item_price)
  end

  def find_golden_items(minimum)
    se.items.all.reduce([]) do |result, item|
      result << item if item.unit_price >= minimum
      result
    end
  end
end
