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

end
