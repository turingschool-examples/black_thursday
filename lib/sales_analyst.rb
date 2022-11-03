require_relative './sales_engine'
require_relative './merchant_repo'
require_relative './item_repo'
require_relative './merchant'
require_relative './item'

class SalesAnalyst

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    find_average
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation
  end

  def merchants_with_high_item_count
    @sales_engine.find_merchants_with_most_items
  end

  def convert_to_list(items)
    found = items.each_with_object([]) do |item, array|
      array << item.unit_price.to_f
      array
    end
    found
  end

  def average_item_price_for_merchant(id)
    items = @sales_engine.find_items_by_id(id)
    expected = convert_to_list(items).sum(0.0) / convert_to_list(items).size
    result = BigDecimal(expected, 4)
    result.div(100, 4)
  end

  def average_average_price_per_merchant
    result = @sales_engine.merchants.merchant_list.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    expected = result.sum(0.0) / result.size
    total_averages = BigDecimal(expected, 5).to_s("F")
    total_averages.to_f.floor(2)
  end

  def find_average
    (@sales_engine.items.item_list.count.to_f / @sales_engine.merchants.merchant_list.count.to_f).round(2)
  end


  # def standard_deviation
  #   sum = 0
  #   avg = average_average_price_per_merchant
  #   @sales_engine.items.all.each do |item|
  #     sum += (item.unit_price.to_f - avg)**2
  #   end
  #   variance = sum / (@sales_engine.items.all.length - 1)
  #   Math.sqrt(variance)
  # end

  def standard_deviation
    merchants = @sales_engine.merchants.all.map do |merchant|
      @sales_engine.items.find_all_by_merchant_id(merchant.id).count
    end
    average = find_average
    differences = 0
    merchants.map do |num|
      differences += (num - average)**2
    end
    Math.sqrt(differences / (merchants.count - 1).to_f).round(2)
  end


  # def golden_items
  #   two_above = (standard_deviation * 2)
  #   golden_item_price = (two_above + average_average_price_per_merchant)
  #   golden_item_list = []
  #   @sales_engine.items.item_list.each do |item|
  #     if item.unit_price_to_dollars >= golden_item_price
  #       golden_item_list << item.unit_price_to_dollars
  #     end
  #   end
  #   golden_item_list
  # end

  def golden_items
    require 'pry'; binding.pry
    golden_price = find_average + standard_deviation * 2
    @sales_engine.items.all.find_all do |item|
      item.unit_price.to_f > golden_price
    end
  end
end
