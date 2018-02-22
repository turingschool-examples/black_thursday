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

end
