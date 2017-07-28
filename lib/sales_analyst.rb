require 'pry'

class SalesAnalyst

  attr_reader :se

  def initialize(se)
    @se = se
  end

  def average_item_price
    set = set_of_item_prices
    sum = sum_array(set_of_item_prices)
    sum / set.count
  end

  def average_items_per_merchant
    ((@se.items.all.count.to_f) / (@se.merchants.all.count.to_f)).round(2)
  end

  def standard_deviation(values)
    average = values.reduce(:+)/values.length.to_f
    average_average = values.reduce(0) {|val, num| val += ((num - average)**2) }
    Math.sqrt(average_average / (values.length-1)).round(2)
  end

  def average_items_per_merchant_standard_deviation
    set = set_of_merchant_items
    standard_deviation(set)
  end

  def set_of_item_prices
    set = []
    @se.items.all.map do |item|
      set << item.unit_price_to_dollars
    end
    set
  end

  def set_of_merchant_items
    set = []
    @se.merchants.all.map do |merchant|
      set << merchant.items.count
    end
    set
  end

  def merchants_with_high_item_count
    @se.merchants.all.find_all do |merchant|
      merchant.items.count > (average_items_per_merchant + average_items_per_merchant_standard_deviation)
    end
  end

  def average_item_price_for_merchant(merch_id)
    merchant = @se.merchants.find_by_id(merch_id)
    num_of_items = merchant.items.count
    if num_of_items != 0
      sum_of_prices = merchant.items.inject(0) do |sum, item|
        sum += item.unit_price_to_dollars
      end
      result = sum_of_prices/num_of_items
    else
      return nil
    end
    result.round(2)
  end

  def average_average_price_per_merchant
    all_merch_ids = @se.merchants.all.map do |merchant|
      merchant.id
    end
    total_averages = []
    all_merch_ids.each do |merch_id|
      if average_item_price_for_merchant(merch_id) != nil
        total_averages << average_item_price_for_merchant(merch_id)
      end
    end
    sum = sum_array(total_averages)
    (sum / total_averages.count).round(2)
  end

  def sum_array(array)
    sum = array.inject(0) do |sum, num|
      sum += num
    end
  end

  def average_item_price_standard_deviation
    set = set_of_item_prices
    standard_deviation(set)
  end

  def golden_items
    @se.items.all.find_all do |item|
      item.unit_price_to_dollars > (average_item_price + (average_item_price_standard_deviation * 2)).round(2)
    end
  end

  def average_invoices_per_merchant
    ((@se.invoices.all.count.to_f) / (@se.merchants.all.count.to_f)).round(2)
  end

  def set_of_merchant_invoices
    set = []
    @se.merchants.all.map do |merchant|
      set << merchant.invoices.count
    end
    set
  end

  def average_invoices_per_merchant_standard_deviation
    set = set_of_merchant_invoices
    standard_deviation(set)
  end

  def top_merchants_by_invoice_count
    std_dev = (average_invoices_per_merchant_standard_deviation * 2)
    mean = average_invoices_per_merchant
    @se.merchants.all.find_all do |merchant|
      (merchant.invoices.count - mean) > std_dev
    end
  end

  def bottom_merchants_by_invoice_count
    std_dev = (average_invoices_per_merchant_standard_deviation * 2)
    mean = average_invoices_per_merchant
    @se.merchants.all.find_all do |merchant|
      (mean - merchant.invoices.count) > std_dev
    end
  end

  def average_invoice_count
    set = set_of_merchant_invoices
    total_merchant_count = @se.merchants.all.count
    set.count / total_merchant_count
  end

  def turn_date_to_day(date)
    date = Date.parse(date)
    date.strftime("%A")
  end

  def generate_deviation(mean, items)
    pre_deviation = (items.reduce(0) do |sum, avg_num|
      sum + ((avg_num - mean) ** 2)
    end)/(items.count - 1).to_f
    Math.sqrt(pre_deviation).round(2)
  end

  def collect_invoices_per_day
    @se.invoices.all.reduce(Hash.new(0)) do |days, invoice|
      invoice_day = invoice.created_at.strftime("%A")
      days[invoice_day] += 1
      days
    end
  end

  def top_days_by_invoice_count
    average = (@se.invoices.all.count / 7).to_f
    invoices_per_day = collect_invoices_per_day.values
    day_deviation = generate_deviation(average, invoices_per_day)
    var = collect_invoices_per_day.find_all do |day, count|
      count > (average + day_deviation)
    end
    var = var.map do |day|
      day.join.to_s[0..-4].split
    end.flatten
  end

  def calculate_invoice_percentage
    status = @se.invoices.all.map{|invoice| invoice.status}
    status = status.reduce(Hash.new(0)){|status, num| status[num] += 1; status}
    sum = status.values.inject(:+)
    status.each_with_object(Hash.new(0)){|(stat, num), hash|
      hash[stat] = num * 100.0 / sum}
  end

  def invoice_status(status)
    calculate_invoice_percentage[status].round(2)
  end

end
