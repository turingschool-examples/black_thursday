require 'pry'
class SalesAnalyst
  def initialize(sales_engine)
    @sales_engine = sales_engine
    average_items_per_merchant
    average_average_price_per_merchant
  end

  def average_items_per_merchant
    @group_by_number_of_items = @sales_engine.items.all.group_by do |item|
      item.merchant_id
    end
    @items_per_merchant = @group_by_number_of_items.map do |key, value|
      value.count
    end
    @average = @items_per_merchant.reduce(:+) / @group_by_number_of_items.size.to_f
    @average.round(2)
  end

  def average_items_per_merchant_standard_deviation
    @std_dev = Math.sqrt(@items_per_merchant.map do |number|
      (number - @average)**2
    end.inject(:+) / (@items_per_merchant.length - 1)).round(2)
    @std_dev
  end

  def merchants_with_high_item_count
    average_items_per_merchant_standard_deviation
    hash = {}
    @group_by_number_of_items.each do |merchant, items|
      hash[merchant] = items.length
    end
    hash.select do |merchant, number|
      merchant if number > (@average + @std_dev)
     end.map do |merchant_id, value|
       @sales_engine.merchants.find_by_id(merchant_id)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    average = @group_by_number_of_items[merchant_id].map do |item|
      item.unit_price
    end.reduce(:+) / (@group_by_number_of_items[merchant_id].count)
    average.round(2)
  end

  def average_average_price_per_merchant
    all_ids = @group_by_number_of_items.map do |merchant_id, value|
      merchant_id
    end
    @all_average_price = all_ids.map do |id|
      average_item_price_for_merchant(id)
    end
    @average_of_averages = (@all_average_price.reduce(:+) / (all_ids.count))
    @average_of_averages = @average_of_averages.round(2)
    @average_of_averages
  end

  def price_std_dev
    all_prices = @sales_engine.items.all.map do |item|
      item.unit_price
    end
    @price_dev = Math.sqrt(all_prices.map do |number|
      (number - average_average_price_per_merchant)**2
    end.inject(:+) / (all_prices.length - 1)).round(2)
    @price_dev
  end

  def golden_items
    price_std_dev
    @sales_engine.items.all.select do |item|
      item if item.unit_price > ((@price_dev * 2) + @average_of_averages)
    end
  end


end