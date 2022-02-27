require_relative 'item_repository'
require_relative 'invoice_repository'
require 'bigdecimal/util'
require 'date'

class SalesAnalyst
  attr_reader :merchants, :items, :invoices, :inv_per_day
  def initialize(merchants, items, invoices)
    @merchants = merchants
    @items = items
    @invoices = invoices
    @@inv_per_day = []
  end

  def list_all_items_by_merchant
    items_by_merchant = []

    @items.all.each do |item|
      items_by_merchant <<  @items.find_all_by_merchant_id(item.merchant_id)
    end
    items_by_merchant.uniq
  end

  def average_items_per_merchant
    all_items_by_merchant = list_all_items_by_merchant
    nums = []
    all_items_by_merchant.uniq.each { |sub_arr| nums << sub_arr.length }
    (nums.sum(0.0) / nums.length).round(2)
  end


  def average_items_per_merchant_standard_deviation
    all_items_by_merchant = list_all_items_by_merchant
    mean = average_items_per_merchant
    math_arr = []

    all_items_by_merchant.each { |sub_arr| math_arr << (sub_arr.length - mean) ** 2 }
    Math.sqrt((math_arr.sum)/474).round(2)
  end

  def merchants_with_high_item_count
    all_items_by_merchant = list_all_items_by_merchant
    average = average_items_per_merchant
    std_dev = average_items_per_merchant_standard_deviation

    high_item_count = all_items_by_merchant.find_all{|merchant| merchant.length > (average + std_dev)}
    merchant_ids = high_item_count.map{|merchants|merchants[0].merchant_id}
    merchant_ids.map{|id|@merchants.find_by_id(id)}
  end

  def average_item_price_for_merchant(id)
    all_items = @items.find_all_by_merchant_id(id)
    all_prices = all_items.map {|item|item.unit_price}
    average = all_prices.sum(0.0)/all_items.length
    average.round(2)
  end

  def average_average_price_per_merchant
    sum = 0
    item_array = list_all_items_by_merchant
    item_array.each do |elem|
      sum += average_item_price_for_merchant(elem[0].merchant_id)
    end
    (sum / item_array.length).round(2)
  end

  def average_item_price
    total_price = 0
    @items.all.each do |item|
      total_price += item.unit_price
    end
    (total_price / @items.all.length).round(2)
  end

  def item_price_standard_deviation
    all_items = @items.all
    avg = average_item_price
    math_arr = []
    all_items.each do |item|
      math_arr << (item.unit_price - avg) ** 2
    end
    Math.sqrt(math_arr.sum / (all_items.length) - 1).round(2)
  end

  def golden_items
    std_dev = item_price_standard_deviation
    avg = average_item_price
    @items.all.find_all{|item| item.unit_price > (std_dev * 2) + avg}
  end

  def list_all_invoices_by_merchant
    invoices_by_merchant = []
    @invoices.all.each do |invoice|
      invoices_by_merchant <<  @invoices.find_all_by_merchant_id(invoice.merchant_id)
    end
    invoices_by_merchant.uniq
  end

  def average_invoices_per_merchant
    all_invoices_by_merchant = list_all_invoices_by_merchant
    nums = []
    all_invoices_by_merchant.each { |sub_arr| nums << sub_arr.length }
    (nums.sum(0.0) / nums.length).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    all_invoices_by_merchant = list_all_invoices_by_merchant
    mean = average_invoices_per_merchant
    math_arr = []

    all_invoices_by_merchant.each { |sub_arr| math_arr << (sub_arr.length - mean) ** 2 }
    Math.sqrt((math_arr.sum(0.0))/(all_invoices_by_merchant.length)).round(2)
  end

  def top_merchants_by_invoice_count
    std_dev = average_invoices_per_merchant_standard_deviation
    avg = average_invoices_per_merchant
    invoices_by_merchant = list_all_invoices_by_merchant
    top_merchants = invoices_by_merchant.find_all{|merchant| merchant.count > (std_dev * 2) + avg}
    arry = []
    top_merchants.each {|merchant| arry << @merchants.find_by_id(merchant[0].merchant_id)}
    arry
  end

  def bottom_merchants_by_invoice_count
    std_dev = average_invoices_per_merchant_standard_deviation
    avg = average_invoices_per_merchant
    invoices_by_merchant = list_all_invoices_by_merchant
    top_merchants = invoices_by_merchant.find_all{|merchant| merchant.count < (avg -(std_dev * 2))}
    arry = []
    top_merchants.each {|merchant| arry << @merchants.find_by_id(merchant[0].merchant_id)}
    arry
  end

  def invoices_by_days_of_the_week
    created_at_dates = []
    @invoices.all.each {|invoice| created_at_dates << invoice.created_at}
    days_of_week = []
    created_at_dates.each {|date| days_of_week << Date.parse(date).wday}
    ordered_days_of_week = []
    (0..6).each { |num| ordered_days_of_week << days_of_week.find_all{|day| day == num} }
    ordered_days_of_week
  end

  def average_invoices_per_day_of_week
    days_of_week = invoices_by_days_of_the_week
    @inv_per_day = []
    days_of_week.each {|day| @inv_per_day << day.length}
    @inv_per_day.sum/days_of_week.length
  end

  def invoices_per_day_of_week_std_deviation
    days_of_week = invoices_by_days_of_the_week
    avg = average_invoices_per_day_of_week

    math_arr = []
    days_of_week.each { |day| math_arr << (day.length - avg) ** 2 }
    Math.sqrt((math_arr.sum(0.0))/(invoices_by_days_of_the_week.length - 1)).round(2)
  end

  def day_converter(num)
    return "Sunday" if num == 0
    return "Monday" if num == 1
    return "Tuesday" if num == 2
    return "Wednesday" if num == 3
    return "Thursday" if num == 4
    return "Friday" if num == 5
    return "Saturday" if num == 6
  end

  def top_days_by_invoice_count
    avg = average_invoices_per_day_of_week
    std_dev = invoices_per_day_of_week_std_deviation
    thing = @inv_per_day.each_with_index {|day, index| if day > (std_dev + avg)
      return day_converter(index)
    end}
  end
end
