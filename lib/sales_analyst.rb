class SalesAnalyst
  attr_reader :items,
              :merchants

  def initialize(items, merchants)
    @items     = items
    @merchants = merchants
  end

  def average_items_per_merchant
    (@items.all.length.to_f/@merchants.all.length).round(2)
  end

  def average_item_price_for_merchant(merchant_id)
    items      = @items.find_all_by_merchant_id(merchant_id)
    sum_prices = items.reduce(0) do |sum, item|
      sum += item.unit_price
    end
     return (sum_prices/items.length).round(2)
  end

  def average_average_price_per_merchant
    sum_avgs = @merchants.all.reduce(0) do |sum, merchant|
      sum += average_item_price_for_merchant(merchant.id)
    end
    return (sum_avgs/@merchants.all.length).round(2)
  end

  def mean(set)
    set.reduce(0) do |sum, num|
      sum += num
    end.to_f / set.length
  end

  def standard_deviation(mean, set)
    root = set.map do |num|
      (num - mean) ** 2
    end.reduce(0) do |sum, num|
      sum += num
    end / (set.length - 1)

    Math.sqrt(root).round(2)
  end

  def average_items_per_merchant_standard_deviation
    # refactor this block into a separate method
    merchant_items = @items.all.reduce({}) do |collector, item|
      if collector[item.merchant_id]
        collector[item.merchant_id] += 1
      else
        collector[item.merchant_id] = 1
      end
      collector
    end
    temp_mean = mean(merchant_items.values)
    standard_deviation(temp_mean, merchant_items.values)
  end

  def merchants_with_high_item_count
    sd = average_items_per_merchant_standard_deviation
    average_item_count = average_items_per_merchant
    cutoff = sd + average_item_count

    merchant_items = @items.all.reduce({}) do |collector, item|
      if collector[item.merchant_id]
        collector[item.merchant_id] += 1
      else
        collector[item.merchant_id] = 1
      end
      collector
    end

    merchant_ids = merchant_items.reduce([]) do |collector, (key, value)|
      if value >= cutoff
        collector << key
      end
      collector
    end
    merchant_ids.map do |merchant_id|
      @merchants.find_by_id(merchant_id)
    end
  end

  def golden_items

    item_price_array = @items.all.reduce([]) do |collector, item|
      collector << item.unit_price
    end

    average_price = mean(item_price_array)
    sd = standard_deviation(average_price, item_price_array)

    @items.all.reduce([]) do |collector, item|
      if item.unit_price >= (2 * sd + average_price)
        collector << item
      end
      collector
    end
  end


end
