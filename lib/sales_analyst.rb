require 'bigdecimal'

class SalesAnalyst
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def merchants
    @sales_engine.merchants.all
  end

  def items
    @sales_engine.items.all
  end

  def average_items_per_merchant
    (items.count.to_f / merchants.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    Math.sqrt(
      merchants.reduce(0) do |sum, merchant|
        sum + ((merchant.item_count - average_items_per_merchant)**2)
      end / (merchants.count - 1)
    ).round(2)
  end

  def one_standard_deviation_above_average
    average_items_per_merchant + average_items_per_merchant_standard_deviation
  end

  def merchants_with_high_item_count
    merchants.find_all do |merchant|
      merchant.item_count > one_standard_deviation_above_average
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = @sales_engine.find_merchant_by_merchant_id(merchant_id)
    return merchant.average_item_price
  end

  def average_average_price_per_merchant
    average = merchants.reduce(0) do |total, merchant|
      total + merchant.average_item_price
    end / merchants.count
    return BigDecimal.new(average.to_s)
  end

  def average_price_per_merchant_standard_deviation
    Math.sqrt(
      items.reduce(0) do |sum, item|
        sum + ((item.unit_price - average_average_price_per_merchant)**2)
      end / (merchants.count - 1)
    ).round(2)
  end

  def two_standard_deviations_above_average_price
    two_standard_deviations = average_price_per_merchant_standard_deviation * 2
    return average_average_price_per_merchant + two_standard_deviations
  end

  def golden_items
    items.find_all do |item|
      item.unit_price > two_standard_deviations_above_average_price
    end
  end
end
