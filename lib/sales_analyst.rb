require 'pry'
class SalesAnalyst
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    @group_by_number_of_items = @sales_engine.items.all.group_by do |item|
      item.merchant_id
    end
    @items_per_merchant = @group_by_number_of_items.map do |key, value|
      value.count
    end
    @average = @items_per_merchant.reduce(:+) / @group_by_number_of_items.size.to_f
    @average.round(2)
  end

  def average_items_per_merchant_standard_deviation
    average_items_per_merchant
    @std_dev = Math.sqrt(@items_per_merchant.map do |number|
      (number - @average)**2
    end.inject(:+) / (@items_per_merchant.length - 1)).round(2)
    @std_dev
  end

  def merchants_with_high_item_count
    average_items_per_merchant_standard_deviation
    hash = {}
    @group_by_number_of_items.each do |merchant, items|
      hash[merchant] = items.length
    end
    hash.map do |merchant, number|
      merchant if number > (@average + @std_dev)
    end.compact.map do |merchant_id|
      @sales_engine.merchants.find_by_id(merchant_id)
    end
    binding.pry
  end
end