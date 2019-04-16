require 'pry'

class SalesAnalyst
  def initialize(merchants, items)
    @merchants = merchants
    @items = items
  end

  def average_items_per_merchant
    grouped_by_merchant_id = @items.all.group_by do |item|
      item.merchant_id
    end
    items_per_merchant = grouped_by_merchant_id.values.map do |value|
      value.count
    end
    mimic_sum = items_per_merchant.inject(0.0) do |sum, num|
      sum + num
    end
    (mimic_sum / items_per_merchant.count).round(2)
  end

  def standard_deviation(data_set)
    data_set_total = data_set.inject(0.0) do |sum, num|
      sum + num
    end
    data_set_average = data_set_total / data_set.count
    data_set_squared = data_set.inject(0.0) do |sum, num|
      sum + (num - data_set_average) ** 2
    end
    Math.sqrt(data_set_squared / (data_set.count - 1))

  end

  def average_items_per_merchant_standard_deviation
    grouped_by_merchant_id = @items.all.group_by do |item|
      item.merchant_id
    end
    items_per_merchant = grouped_by_merchant_id.values.map do |value|
      value.count
    end
    standard_deviation(items_per_merchant).round(2)
  end

  def merchants_with_high_item_count
    grouped_by_merchant_id = @items.all.group_by do |item|
      item.merchant_id
    end

    high_count_merchants = []
    high_count_cutoff = (average_items_per_merchant_standard_deviation +
    average_items_per_merchant)

    grouped_by_merchant_id.each do |merchant_id, items|
      if items.count > high_count_cutoff
        high_count_merchants << @merchants.find_by_id(merchant_id)
      end
    end
    high_count_merchants
  end

  def average_item_price_for_merchant(for_merchant_id)
    grouped_by_merchant_id = @items.all.group_by do |item|
      item.merchant_id
    end
     merchants_items = grouped_by_merchant_id[for_merchant_id]
     mimic_sum = merchants_items.inject(0.0) do |sum, item|
       sum + item.unit_price
     end
     (mimic_sum / merchants_items.count).round(2)
  end

  def average_average_price_per_merchant
    merchant_price_averages = @merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    mimic_sum = merchant_price_averages.inject(0.0) do |sum, price_average|
      sum + price_average
    end
    (mimic_sum / merchant_price_averages.count).round(2)
  end

  def golden_items
    item_prices = @items.all.map do |item|
      item.unit_price
    end

    sd_item_prices = standard_deviation(item_prices)
    average_price = average_average_price_per_merchant.to_f
    golden_item_cutoff = sd_item_prices * 2 + average_price
    golden_priced_items = []
    @items.all.each do |item|
      if item.unit_price > golden_item_cutoff
        golden_priced_items << item
      end
    end
    golden_priced_items
  end



end
