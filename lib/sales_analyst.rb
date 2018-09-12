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

end
