require 'pry'

class SalesAnalyst
  attr_reader :sales_engine,
              :items,
              :merchants

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @items = load_items
    @merchants = load_merchants
  end

  def load_items
    sales_engine.load_items
    # make sure this only happens once. Needs if or something
  end

  def load_merchants
    self.sales_engine.merchants.all
  end

  def average(array)
    array.inject{ |sum, element| sum + element }.to_f / array.count
  end

  def find_standard_deviation(array)
    mean = average(array)
    n = array.length
    sum_squares = array.inject(0) { |sum, element| sum + (mean - element)**2 }
    Math.sqrt(sum_squares / (n-1))
  end

  def average_items_per_merchant
    items_count      = sales_engine.items.all.count
    merchants_count  = sales_engine.merchants.all.count
    average          = items_count.to_f / merchants_count.to_f
    average.round(2)
  end

  def average_items_per_merchant_standard_deviation
    items_per_merchant = load_merchant_items
    result = find_standard_deviation(items_per_merchant)
    return result.round(2)
  end

  def load_merchant_items
    array = []
    @merchants.each do |merchant_instance|
      if @items.keys.include?(merchant_instance.id)
        array << merchant_instance.id
      end
    end
    array_counts = array.map do |array|
      binding.pry
      array.count
    end
    return array_counts
  end

  def merchants_with_high_item_count
    std_dev = average_items_per_merchant_standard_deviation
    average_ip  = average_items_per_merchant
    var = std_dev + average_ip
    array = @merchants.all.map do |merchant_instance|
      binding.pry
        items[merchant_instance.id].count > var
      end
      array
    # if merchants.std_dev + average_ip
    # return merchants with more than one standard deviation
    # above average number of items as an ARRAY
  end

  def average_item_price_for_merchant(id)
    # take in merchant id
    # take in list of merchant's items' prices
    # return average of those prices as a BIGDECIMAL
    average_price = average(prices)
    return BigDecimal.new(average_price, 4)
  end

  def average_average_price_per_merchant
    # average accross all merchant's average prices
    # return BIGDECIMAL
    average_price = average(prices)
    return BigDecimal.new(average_price, 4)
  end

  def golden_items
    # take in standard deviation, average price
    # search for items that are 2 standard deviations above
    # average and return ARRAY of those item objects
  end
end
