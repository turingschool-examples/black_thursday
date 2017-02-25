require 'pry'

class SalesAnalyst
  attr_reader :se_inst

  def initialize(se_inst)
    @se_inst = se_inst
  end

  def average_items_per_merchant
	(se_inst.items.all.count.to_f / se_inst.merchants.all.count.to_f).round(2)
  end

  def diff_btw_mean_and_item_c_sqrd_summed
    mean = average_items_per_merchant
    get_merchant_items_set.map { |item_c| (item_c - mean) ** 2 }.reduce(:+)
  end

  def get_merchant_items_set
    se_inst.merchants.all.map { |merchant| merchant.items.count }
  end

  def average_items_per_merchant_standard_deviation
    set_length = (get_merchant_items_set.length - 1)
    Math.sqrt(diff_btw_mean_and_item_c_sqrd_summed/set_length).round(2)
  end

  def merchants_with_high_item_count
    avg = average_items_per_merchant
    std_dev = (average_items_per_merchant_standard_deviation)
    se_inst.merchants.all.select do |merchant|
      merchant.items.count >= (std_dev + avg)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    item_list = se_inst.merchants.find_by_id(merchant_id).items
    (item_list.reduce(0.0) { |price_total, item| price_total + item.unit_price } / item_list.size).round(2)
  end

  def average_average_price_per_merchant
    merch_avgs = se_inst.merchants.all.map { |merchant| average_item_price_for_merchant(merchant.id) }
    (merch_avgs.reduce(:+)/merch_avgs.count).round(2)
  end

  def average_item_price
    all_items = se_inst.items.all
    (all_items.reduce(0.0) { |total, item| total + item.unit_price} / all_items.count.to_f).round(2)
  end

  def get_item_price_set
    se_inst.items.all.map {|item| item.unit_price}
  end

  def difference_between_mean_and_item_price_squared_summed
    mean = average_item_price
    get_item_price_set.map { |item_price| (item_price - mean) ** 2 }.reduce(:+)
  end

  def average_item_price_standard_deviation
    set_length = (get_item_price_set.length - 1)
    Math.sqrt(difference_between_mean_and_item_price_squared_summed/set_length).round(2)
  end

  def golden_items
    avg = average_item_price
    std_dev = average_item_price_standard_deviation
    se_inst.items.all.select {|item| item.unit_price >= ((std_dev + avg) * 2) }
  end

end
