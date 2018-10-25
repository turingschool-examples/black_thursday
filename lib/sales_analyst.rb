require 'pry'


class SalesAnalyst
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def items_by_merchant
    @items.all.group_by {|item| item.merchant_id}
  end

  def average_items_per_merchant
    (items_by_merchant.values.flatten.count.to_f/items_by_merchant.count).round(2)
  end

  def standard_deviation
    items_per_merchant_array = items_by_merchant.values
    items_count = items_per_merchant_array.map do |items|
      items.count
    end
    squared_difference_array =
     items_count.map do |item_count|
       (item_count - average_items_per_merchant)**2
     end
     # binding.pry
     Math.sqrt(((squared_difference_array.reduce(:+))/(items_by_merchant.count-1))).round(2)
  end

  def merchants_with_high_item_count
  end

end
