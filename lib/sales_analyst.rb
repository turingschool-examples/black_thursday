
class SalesAnalyst
  def initialize(sales_engine)
    @se = sales_engine
  end

  def average_items_per_merchant
    mean_items_per_merchant(items_count_per_merchant).round(2)
  end

  def average_items_per_merchant_standard_deviation
    num_items = items_count_per_merchant
    mean = mean_items_per_merchant(num_items)
    std_dev = 0.0
    num_items.each do |count|
      std_dev += (count - mean)**2
    end
    std_dev /= num_items.length - 1
    Math.sqrt(std_dev).round(2)
  end

  def mean_items_per_merchant(item_array)
    mean = 0.0
    item_array.each do |count|
      mean += count
    end
    mean / item_array.length
  end

  def items_count_per_merchant
    @se.merchants.all.map do |merchant|
      @se.find_items_by_merchant_id(merchant.id).length
    end
  end

  def merchants_with_high_item_count
    mean = average_items_per_merchant
    std_dev = average_items_per_merchant_standard_deviation
    @se.merchants.all.find_all do |merchant|
      @se.find_items_by_merchant_id(merchant.id).length > (std_dev + mean)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    items = @se.find_items_by_merchant_id(merchant_id)
    avg = 0
    items.each do |item|
      avg += item.unit_price
    end
    if items.length == 0
      0
    else
      (avg /= items.length).round(2)
    end
  end

  def average_average_price_per_merchant
    avg = 0
    merchants = @se.merchants.all
    merchants.map do |merchant|
      avg += average_item_price_for_merchant(merchant.id)
    end
    (avg /= merchants.length).round(2)
  end

  def golden_items
    item_array = @se.items.all
    mean = avg_item_price(item_array)
    std_dev = std_dev_item_price(mean, item_array)
    item_array.find_all { |item| item.unit_price > ((std_dev * 2) + mean) }
  end

  def avg_item_price(item_array)
    avg = 0
    item_array.each do |item|
      avg += item.unit_price
    end
    avg /= item_array.length
  end

  def std_dev_item_price(mean, item_array)
    std_dev = 0
    item_array.each do |item|
      std_dev += (item.unit_price - mean)**2
    end
    std_dev /= item_array.length - 1
    Math.sqrt(std_dev).round(2)
  end

end
