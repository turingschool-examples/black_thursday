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
    get_item_price_set.map { |item_price| (item_price - mean) ** 2 }.reduce(:+).round(2)
  end

  def average_item_price_standard_deviation
    set_length = (get_item_price_set.length - 1)
    Math.sqrt(difference_between_mean_and_item_price_squared_summed/set_length).round(2)
  end

  def golden_items
    avg = average_item_price
    std_dev = average_item_price_standard_deviation
    se_inst.items.all.select {|item| item.unit_price >= (avg + (std_dev * 2)) }
  end

  def average_invoices_per_merchant
    (se_inst.invoices.all.count.to_f / se_inst.merchants.all.count.to_f).round(2)
  end

  def get_merchant_invoices_set
    se_inst.merchants.all.map do |merchant|
      se_inst.invoices.find_all_by_merchant_id(merchant.id).count
    end
  end

  def difference_between_mean_and_invoice_count_squared_summed
    mean = average_invoices_per_merchant
    get_merchant_invoices_set.map { |invoices| (invoices - mean) ** 2 }.reduce(:+).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    set_length = (get_merchant_invoices_set.count - 1)
    Math.sqrt(difference_between_mean_and_invoice_count_squared_summed/set_length).round(2)
  end

  def top_merchants_by_invoice_count
    std_dev = average_invoices_per_merchant_standard_deviation
    avg = average_invoices_per_merchant
    se_inst.merchants.all.select do |merchant|
      merchant.invoices.count >= (avg + (std_dev * 2))
    end
  end

  def bottom_merchants_by_invoice_count
    std_dev = average_invoices_per_merchant_standard_deviation
    avg = average_invoices_per_merchant
    se_inst.merchants.all.select do |merchant|
      merchant.invoices.count <= (avg - (std_dev * 2))
    end
  end

  def invoice_status(status)
    status_count = se_inst.invoices.all.count do |invoice|
      invoice.status == status
    end
    (100 * status_count.to_f / se_inst.invoices.all.count.to_f).round(2)
  end

  def get_wdays
    se_inst.invoices.all.map do |invoice|
      invoice.created_at.wday
    end
  end

  def days_of_the_week
  {"Sunday" => 0,
   "Monday" => 1,
   "Tuesday" => 2,
   "Wednesday" => 3,
   "Thursday" => 4,
   "Friday" => 5,
   "Saturday" => 6
 }.invert
end

  def frequency_created_per_day
    day_count = Hash.new(0)
      get_wdays.each do |wday_num|
      day_count[days_of_the_week[wday_num]] += 1
    end
    day_count
  end

  def average_invoices_per_day
    frequencies = frequency_created_per_day.values
    (frequencies.reduce(:+).to_f / frequencies.count.to_f).round(2)
  end

  def diff_btw_mean_and_day_frequency_sqrd_summed
    mean = average_invoices_per_day
    frequency_created_per_day.values.map do |day_freq|
      (day_freq - mean) ** 2
    end.reduce(:+).round(2)
  end

  def average_frequency_per_day_standard_deviation
    set_length = (frequency_created_per_day.values.count - 1)
    Math.sqrt(diff_btw_mean_and_day_frequency_sqrd_summed/set_length).round(2)
  end

  def top_days_by_invoice_count
    avg = average_invoices_per_day
    std_dev = average_frequency_per_day_standard_deviation
    frequency_created_per_day.select do |day, frequency|
      frequency >= (std_dev + avg)
    end.keys
  end

  # def find_merchant_greater_count
  #   std_dev = average_invoices_per_merchant_standard_deviation
  #   avg = average_invoices_per_merchant
  #   se_inst.merchants.all.detect do |merchant|
  #     merchant.invoices.count <= 1
  #   end
  # end
end
