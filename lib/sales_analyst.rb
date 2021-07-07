require 'pry'
class SalesAnalyst

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    (@sales_engine.items.repo.count.to_f / @sales_engine.merchants.repo.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    diff_squared =
    differences_squared(items_per_merchant_hash.values,average_items_per_merchant)
    summed = sum_values(diff_squared)
    divided_sum = summed / (items_per_merchant_hash.count - 1)
    Math.sqrt(divided_sum).round(2)
  end

  def items_per_merchant_hash
    merchant_id_array.inject(Hash.new(0)) do |total, id|
      total[id] += 1
      total
    end
  end

  def merchant_id_array
    merchant_ids = @sales_engine.items.repo.map do |item|
      item.merchant_id
    end
  end

  def merchants_with_high_item_count
    highest_count = items_per_merchant_hash.find_all do |merchant|
      merchant[1] > (average_items_per_merchant + average_items_per_merchant_standard_deviation)
    end
    highest_count.map do |merchant|
      @sales_engine.merchants.find_by_id(merchant[0])
    end
  end

  def average_item_price_for_merchant(merchant_id)
    items = @sales_engine.items.find_all_by_merchant_id(merchant_id)
    summed_unit_price = items.inject(0) do |sum,item|
      sum + item.unit_price
    end
    (summed_unit_price/items.count).round(2)
  end

  def average_average_price_per_merchant
    average_of_all_merchants = items_per_merchant_hash.map do |merchant|
      average_item_price_for_merchant(merchant[0])
    end
    summed = sum_values(average_of_all_merchants)
    (summed / @sales_engine.merchants.repo.count).round(2)
  end

  def average_item_cost
    summed = sum_values(array_of_unit_price)
    # binding.pry
    (summed / @sales_engine.items.repo.count).round(2)
  end

  def golden_items_standard_deviation
    differences_squared = @sales_engine.items.repo.map do |item|
      (item.unit_price - average_item_cost) ** 2
    end
    summed = sum_values(differences_squared)
    divided_sum = summed / (@sales_engine.items.repo.count - 1)
    Math.sqrt(divided_sum).round(2)
  end

  def golden_items
  @sales_engine.items.repo.find_all do |item|
      item.unit_price > (average_item_cost + (golden_items_standard_deviation * 2 ))
    end
  end

  def array_of_unit_price
    @sales_engine.items.repo.map do |item|
      item.unit_price
    end
  end

  def differences_squared(nums_array,average)
    nums_array.map do |number|
    (number - average) ** 2
    end
  end

  def sum_values(array)
    array.inject(0) do |sum,num|
      sum + num
    end
  end

  def inspect
   "#<#{self.class} #{@merchant.size} rows>"
  end

end
