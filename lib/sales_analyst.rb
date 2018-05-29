require_relative 'sales_engine.rb'
require 'pry'

class SalesAnalyst

  def initialize(item_repository, merchant_repository)
    @items = item_repository
    @merchants = merchant_repository
    @id_counts = {}
    @average_items = average_items_per_merchant
    @items_standard_deviation = average_items_per_merchant_standard_deviation
    @average_price = average_total_item_price
    @price_standard_deviation = item_price_standard_deviation
  end

  def average_items_per_merchant
    sum = 0.00
    items_per_merchant.each do |count|
      sum += count
    end
    average = (sum / items_per_merchant.length).round(2)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(items_per_merchant, @average_items)
  end

  def standard_deviation(array, average)
    count_less_one = (array.count - 1)
    sum = 0.00
    array.map do |amount|
      sum += (amount - average) ** 2
    end
    standard_deviation = ((sum / count_less_one) ** (1.0/2)).round(2)
  end

  def items_per_merchant
    unique_ids = merchant_ids.uniq
    unique_ids.map do |id|
      @id_counts[id] = merchant_ids.count(id)
      id = merchant_ids.count(id)
    end
  end

  def merchant_ids
    @items.all.map do |item|
      item = item.merchant_id
    end
  end

  def merchants_with_high_item_count
    high_count = @average_items + @items_standard_deviation
    good_merchants = []
    @id_counts.each do |id, count|
      if count >= high_count
        good_merchants << @merchants.find_by_id(id)
      end
    end
    good_merchants
  end

  def average_item_price_for_merchant(id)
    items = @items.find_all_by_merchant_id(id)
    sum = 0.00
    items.each do |item|
      sum += item.unit_price
    end
    (((sum / 100)) / items.count).to_f.round(2)
  end


  def average_average_price_per_merchant
    sum = 0.00
    @merchants.all.each do |merchant|
      sum += average_item_price_for_merchant(merchant.id)
    end
    (sum / @merchants.all.count).round(2)
  end

  def average_item_prices_for_each_merchant
    @merchants.all.map do |merchant|
      merchant = average_item_price_for_merchant(merchant.id)
    end
  end

  def item_price_standard_deviation
    standard_deviation(all_item_prices, @average_price).round(2)
  end

  def all_item_prices
    @items.all.map do |item|
      item = (item.unit_price / 100)
    end
  end

  def average_total_item_price
    sum = 0.00
    @items.all.map do |item|
      sum += (item.unit_price / 100)
    end
    sum / @items.all.count
  end

  def golden_items
    golden_items = []
    @items.all.map do |item|
      if (item.unit_price / 100) >= (@average_price + (@price_standard_deviation * 2))
        golden_items << item
      end
    end
    golden_items
  end
end
