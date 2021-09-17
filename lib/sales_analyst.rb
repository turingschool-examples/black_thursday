require 'csv'
require 'bigdecimal'
require_relative 'sales_engine'

class SalesAnalyst
  def initialize(repos)
    @items         = repos[:items]
    @merchants     = repos[:merchants]
    @invoices      = repos[:invoices]
    @invoice_items = repos[:invoice_items]
    @transactions  = repos[:transactions]
  end

  def average_items_per_merchant
    (@items.all.length.to_f/@merchants.all.length.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    mean = self.average_items_per_merchant.to_f
    sum = 0.0
    @merchants.all.each do |merchant|
      diff = (mean - @items.find_all_by_merchant_id(merchant.id).length.to_f)
      sum += diff**2
    end
    s_d = Math.sqrt(sum/((@merchants.all.length.to_f)-1))
    s_d.round(2)
  end

  def merchants_with_high_item_count
    mer_array = []
    mean_item = average_items_per_merchant
    s_d = average_items_per_merchant_standard_deviation
    one_above_sd = mean_item + s_d

    @merchants.all.each do |merchant|
      if @items.find_all_by_merchant_id(merchant.id).length > one_above_sd
        mer_array << merchant
      end
    end
    mer_array
  end

  def average_item_price_for_merchant(id)
    items_by_a_mr = @items.find_all_by_merchant_id(id)
    num_of_items = items_by_a_mr.length.to_f
    total_price_item = 0.0

    items_by_a_mr.each do |item|
      total_price_item += item.unit_price
    end

    BigDecimal((total_price_item/num_of_items).round(2))
  end

  def average_average_price_per_merchant
    total = 0
    @merchants.all.each do |merchant|
      total += average_item_price_for_merchant(merchant.id)
    end
    (total/@merchants.all.length.to_f).round(2)
  end

  def average_price_standard_deviation
    mean = average_average_price_per_merchant
    item_count = (@items.all.length.to_f - 1).to_f
    sum = 0.0
    @items.all.each do |item|
      diff = (mean - item.unit_price.to_f)
      sum += diff**2
    end
    s_d = Math.sqrt((sum)/item_count)
    s_d.round(2)
  end

  def golden_items
    array_gold_item = []
    two_s_d = average_price_standard_deviation * 2

    @items.all.each do |item|
      if item.unit_price > two_s_d
        array_gold_item << item
      end
    end
    array_gold_item
  end

  def average_invoices_per_merchant
    (@invoices.all.length.to_f / @merchants.all.length.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    mean = average_invoices_per_merchant
    sum = @merchants.all.sum do |merchant|
      (@invoices.find_all_by_merchant_id(merchant.id).length.to_f - mean) ** 2
    end
    Math.sqrt(sum / ((@merchants.all.length.to_f) -1 )).round(2)
  end

  def top_merchants_by_invoice_count
    mean    = average_invoices_per_merchant
    std_dev = average_invoices_per_merchant_standard_deviation

    @merchants.all.find_all do |merchant|
      (mean + 2 * std_dev) <= @invoices.find_all_by_merchant_id(merchant.id).length
    end
  end

  def bottom_merchants_by_invoice_count
    mean    = average_invoices_per_merchant
    std_dev = average_invoices_per_merchant_standard_deviation

    @merchants.all.find_all do |merchant|
      (mean - 2 * std_dev) >= @invoices.find_all_by_merchant_id(merchant.id).length
    end
  end

  def invoices_by_day
    invoices_by_day = {0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0}
    @invoices.all.each do |invoice|
      time = invoice.created_at.wday
      invoices_by_day[time] += 1
    end
    invoices_by_day
  end

  def invoices_by_day_mean
    invoices_by_day.values.sum.to_f / 7
  end

  def invoices_per_day_standard_deviation
    sum = invoices_by_day.values.sum do |daily_value|
      (daily_value - invoices_by_day_mean) ** 2
    end

    Math.sqrt(sum / 6.0).round(2)
  end

  def top_days_by_invoice_count # => on which days are invoices created at more than one std dev above the mean?
    top_values = invoices_by_day.values.find_all do |value|
      invoices_by_day_mean + invoices_per_day_standard_deviation <= value
    end

    top_values.map do |value|
      Date::DAYNAMES[invoices_by_day.key(value)]
    end
  end

  def invoice_status(status)
    total = @invoices.all.length.to_f
    (100.0 * @invoices.find_all_by_status(status).length / total).round(2)
  end
end
