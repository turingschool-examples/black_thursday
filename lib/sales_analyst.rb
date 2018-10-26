require_relative '../lib/sales_engine'
class SalesAnalyst
  attr_reader     :items, :merchants
  def initialize(items, merchants)
    @items      = items
    @merchants  = merchants
  end

  def count_all_items
    @items.all.count.round(2)
  end

  def count_all_merchants
    @merchants.all.count.round(2)
  end

  def average_items_per_merchant
    (count_all_items / count_all_merchants).round(2)
  end

  def all_merchant_item_count
    @merchants.all.map do |merchant|
      x = merchant.id
      y = items.find_all_by_merchant_id(x)
      y.count
    end
  end

  def merchant_count_minus_average
    avg = average_items_per_merchant
    all_merchant_item_count.map do |num|
      num - avg
    end
  end

  # def average_items_per_merchant_standard_deviation
  #
  #   (array_numbers.inject(:+)) / (@items.all.count - 1.00)
  # end

end
