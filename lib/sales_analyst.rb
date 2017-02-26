require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def all_prices
    sales_engine.items.all.inject(0) do |sum, object|
      sum + object.unit_price_to_dollars
    end
  end

  def all_merchants
    sales_engine.merchants.all.map do |merchant|
      merchant.id
    end
  end

  def all_items
    sales_engine.items.all.map do |item|
      item.id
    end
  end

  def build_hash
    merchant_prices = Hash.new{ |hash, key| hash[key] = [] }
    sales_engine.merchants.all.map do |merchant|
      merchant_items = sales_engine.items.find_all_by_merchant_id(merchant.id)
      merchant_prices[merchant.id] = merchant_items.map {|item| item.unit_price_to_dollars}
    end
    merchant_prices
  end

  def get_prices_of_merchant(merchant_id)
    items = sales_engine.items.find_all_by_merchant_id(merchant_id)
    prices = items.map do |item|
      item.unit_price_to_dollars
    end
    {merchant_id => prices}.to_a
  end

  def average_items_per_merchant
    merchant_count = all_merchants.count
    item_count = all_items.count
    average = item_count.to_f/merchant_count.to_f
    average.round(2)
  end

  def std_dev_from_array(array)
    array.map!{|num| num.to_f }
    mean = array.reduce(:+)/array.length
    sum_sqr = array.map {|number| number * number}.reduce(:+)
    Math.sqrt((sum_sqr - array.length * mean * mean)/(array.length - 1)).round(2)
  end

  def average_items_per_merchant_standard_deviation
    items = build_hash
    item_count = items.map do |key, value|
      value.count
    end
    std_dev_from_array(item_count)
  end


  # def average_items_per_merchant_standard_deviation
  #   data = build_hash
  #   standard_deviation(data)
  # end
  #
end
