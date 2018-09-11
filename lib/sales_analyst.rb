require_relative '../lib/sales_analyst'

class SalesAnalyst

  def initialize(item_repo, merchant_repo)
    @item_repo = item_repo
    @merchant_repo = merchant_repo
  end

  def average_items_per_merchant
    (@item_repo.all.count.to_f / @merchant_repo.all.count).round(2)
  end

  def items_per_merchant_array
    @merchant_repo.all.map do |merchant|
      @item_repo.all.find_all do |item|
        merchant.id == item.merchant_id
      end.count
    end
  end

  def sum(array)
    array.inject(0) do |total, item|
      total += item
    end
  end

  def subtract_square_sum_array
    set = items_per_merchant_array
    average = average_items_per_merchant
    new_set = set.map do |element|
      (average - element)**2
    end
    sum(new_set)
  end

  def average_items_per_merchant_standard_deviation
    step_one = subtract_square_sum_array
    step_two = step_one/(@merchant_repo.all.count - 1)
    Math.sqrt(step_two).round(2)
  end

  def merchant_hash
    return_hash = {}
    @merchant_repo.all.each do |merchant|
      return_hash[merchant] = @item_repo.all.find_all do |item|
        merchant.id == item.merchant_id
      end
    end
    return_hash
  end

  def merchants_with_high_item_count_hash
    merchant_hash.find_all do |key, value|
      value.length >= average_items_per_merchant_standard_deviation + average_items_per_merchant
    end.to_h
  end

  def merchants_with_high_item_count
    merchants_with_high_item_count_hash.keys
  end

  def average_item_price_for_merchant(search_id)
    merchant_array = merchant_hash.find do |merchant, items|
      merchant.id == search_id
    end
    bd_array = merchant_array[1].map do |item|
      item.unit_price
    end
    inject_big_decimal(bd_array)/bd_array.length
  end

  def average_average_price_per_merchant
    array = []
    merchant_hash.each do |key, value|
      array << average_item_price_for_merchant(key.id)
    end

    inject_big_decimal(array)/array.length
  end

  def inject_big_decimal(array)
    array.inject(BigDecimal.new(0,10)) do |sum, bd|
      bd + sum
    end
  end

end
