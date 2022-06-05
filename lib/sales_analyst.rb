require 'helper'
require 'pry'

class SalesAnalyst
  attr_accessor :item_repository,
                :merchant_repository,
                :invoice_repository

  def initialize(item_repository, merchant_repository,invoice_repository)
    @item_repository = item_repository
    @merchant_repository = merchant_repository
    @invoice_repository = invoice_repository
  end

  def average_items_per_merchant #2.88
    (@item_repository.all.count.to_f / @merchant_repository.all.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation #3.26
    counts = []
    @merchant_repository.all.each do |merchant|
      counts <<  @item_repository.find_all_by_merchant_id(merchant.id).count
    end
    total = counts.sum {|difference| (difference - average_items_per_merchant) ** 2}
    Math.sqrt(total / (counts.length - 1)).round(2)
  end

  def merchants_with_high_item_count
    merch_array = []
    @merchant_repository.all.each do |merchant|
      if (@item_repository.find_all_by_merchant_id(merchant.id).count - average_items_per_merchant > average_items_per_merchant_standard_deviation)
        #avg items per merchant
        merch_array << merchant
      end
    end
    merch_array
  end

  def average_item_price_for_merchant(merch_id)
    price_sum_helper(merch_id) / @item_repository.find_all_by_merchant_id(merch_id).count
  end

  def price_sum_helper(merch_id) #31500
    holder_array = @item_repository.find_all_by_merchant_id(merch_id)
    total_sum = holder_array.sum{|item| item.unit_price_to_dollars}
    total_sum
  end

  def average_average_price_per_merchant
    total_sum = 0
    @merchant_repository.all.each do |merchant|
      total_sum += average_item_price_for_merchant(merchant.id)
    end
    (total_sum / @merchant_repository.all.count).round(2)
  end

  def average_item_price
    total_sum = @item_repository.all.sum {|item| item.unit_price_to_dollars}
    (total_sum / @item_repository.all.count).round(2)
  end

  def item_price_standard_deviation
    total = @item_repository.all.sum {|item| (item.unit_price_to_dollars - average_item_price) ** 2}
     Math.sqrt(total / @item_repository.all.count - 1).round(2)
  end

  def golden_items
    standard_dev = item_price_standard_deviation
    @item_repository.all.select {|item| item.unit_price_to_dollars > (average_item_price + (standard_dev * 2))}
  end
  # => first portion in case we want to split in half


  def average_invoices_per_merchant # => 10.49, method + test working
    (@invoice_repository.all.count.to_f / @merchant_repository.all.count.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation # => expect 3.29
    counts = []
    @invoice_repository.all.each do |invoice|
      counts <<  @invoice_repository.find_all_by_customer_id(invoice.id).count
    end
    total = counts.sum {|difference| (difference - average_invoices_per_merchant) ** 2}
    Math.sqrt(total / (counts.length - 1)).round(2)
  end # => currently outputting 9.8 -- METHOD NOT WORKING YET

  def top_merchants_by_invoice_count
    top_merch_array = []
    @merchant_repository.all.each do |merchant|
      if (@item_repository.find_all_by_merchant_id(merchant.id).count > average_items_per_merchant_standard_deviation * 2)
        top_merch_array << merchant
      end
    end
    top_merch_array
  end

  def bottom_merchants_by_invoice_count
    bot_merch_array = []
    @merchant_repository.all.each do |merchant|
      if (@item_repository.find_all_by_merchant_id(merchant.id).count < average_items_per_merchant_standard_deviation * 2)
        bot_merch_array << merchant
      end
    end
    bot_merch_array
    # require 'pry' ; binding.pry
  end

  # will likely want to break below into a TimeAnalyst class or something for organizing purposes

  def invoice_day_of_week_by_id(invoice_id)
    created_at_array = (@invoice_repository.find_by_id(invoice_id).created_at).split("-")
    date = Date.new(created_at_array[0].to_i,created_at_array[1].to_i,created_at_array[2].to_i)
    date.wday
  end

  def invoices_by_day_of_week(day)
    numeric_weekday = Date.parse(day).wday
    @invoice_repository.all.count {|invoice| invoice_day_of_week_by_id(invoice.id) == numeric_weekday}
  end

  def average_invoices_by_day_of_week
    weekdays_array = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]

    ((weekdays_array.sum {|day| invoices_by_day_of_week(day)}).to_f / 7).round(2)
  end

  def average_invoices_by_day_of_week_standard_deviation
    weekdays_array = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    mean = average_invoices_by_day_of_week
    sum = weekdays_array.sum {|day| (invoices_by_day_of_week(day) - mean) ** 2}
    variance = sum / 6
    standard_deviation = Math.sqrt(variance).round(2)
  end

  def top_days_by_invoice_count
    weekdays_array = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    std_dev = average_invoices_by_day_of_week_standard_deviation
    mean = average_invoices_by_day_of_week
    weekdays_array.select {|day| invoices_by_day_of_week(day) - mean > std_dev}
  end

  def invoice_status(status)
    numerator_count = @invoice_repository.find_all_by_status(status).count
    ((numerator_count.to_f / @invoice_repository.all.count.to_f) * 100).round(2)
  end
end
