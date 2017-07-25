
class SalesAnalyst
  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    ((@se.item.all.count.to_f) / (@se.merchant.all.count.to_f)).round(2)
  end

  def average_items_per_merchant_standard_deviation
    set = set_of_merchant_items
    mean = set.inject(:+).to_f / set.size
    Math.sqrt(set.inject(0){|sum,val| sum + (val - mean)**2} / set.size).round(2)
  end

  def set_of_merchant_items
    set = []
    @se.merchant.all.map do |merchant|
      set << merchant.items.count
    end
    set
  end

  def merchants_with_high_item_count
    @se.merchant.all.find_all do |merchant|
      merchant.items.count > (average_items_per_merchant + average_items_per_merchant_standard_deviation)
    end
  end

  def average_item_price_for_merchant(merch_id)
    merchant = @se.merchant.find_by_id(merch_id)
    num_of_items = merchant.items.count
    sum_of_prices = sum_array(merchant.items)
    sum_of_prices/num_of_items
  end

  def average_average_price_per_merchant
    all_merch_ids = @se.merchant.all.map do |merchant|
      merchant.id
    end
    total_averages = all_merch_ids.map do |merch_id|
      average_item_price_for_merchant(merch_id)
    end
    sum = sum_array(total_averages)
    sum / total_averages.count
  end

  def sum_array(array)
    sum = array.inject(0) do |sum, num|
      sum += average
    end
  end


end
