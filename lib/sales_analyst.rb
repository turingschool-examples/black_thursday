require 'bigdecimal'

class SalesAnalyst

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def merchants
    @sales_engine.merchants.all
  end

  def total_items
    @sales_engine.item_count
  end

  def average_items_per_merchant
    (total_items.to_f / merchants.count).round(2)
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
    merchant.average_item_price
  end

  def average_average_price_per_merchant
    merchants.reduce(0) do |total, merchant|
      total + merchant.average_item_price
    end / merchants.count
  end

  def average_price_per_merchant_standard_deviation
    standard_deviations = items.map do |item|
      (item.unit_price - average_average_price_per_merchant)**2
    end
    Math.sqrt(standard_deviations.sum / (total_items - 1))
  end

  def two_standard_deviations_above_average_price
    average_average_price_per_merchant + (average_price_per_merchant_standard_deviation*2)
  end

  def golden_items
    itmes.find_all do |item|
      items.unit_price > two_standard_deviations_above_average_price
    end
  end

end
