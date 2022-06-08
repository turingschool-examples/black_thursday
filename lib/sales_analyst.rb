require_relative 'entry'
require 'date'

class SalesAnalyst < SalesEngine
  attr_reader :item_repository,
              :merchant_repository,
              :invoice_repository,
              :invoice_item_repository,
              :transaction_repository,
              :customer_repository

  def initialize
    @invoice_day_of_week = []
    super
  end

  def average_items_per_merchant
    ((@item_repository.all.count.to_f / @merchant_repository.all.count.to_f).round(2))
  end

  def invoice_paid_in_full?(invoice_id)
    y = @transaction_repository.all.find {|transaction|invoice_id == transaction.invoice_id.to_i}
    return true if y.result == "success"
    return false if y.result != "success"
  end

  def invoice_total(invoice_id)
    matching_invoice_ids = @invoice_item_repository.all.find_all{|invoice| invoice.invoice_id.to_i == invoice_id.to_i}
    unit_price_times_quantity = matching_invoice_ids.map {|invoice|invoice.unit_price.to_i * invoice.quantity.to_i}
    unit_price_times_quantity.sum * 0.01
  end

  def average_item_price_for_merchant(merchant_id)
    x = @item_repository.all.find_all { |item| item.merchant_id == merchant_id }
    y = x.map do |item|
      item.unit_price
    end
      ((y.sum / x.count)/100).ceil(2)
  end

  def average_items_per_merchant_standard_deviation
    merchant_ids = @item_repository.all.group_by {|item| item.merchant_id}
    merch_array = merchant_ids.flat_map {|_,value|value.count}
    merch_item_count = merch_array.map {|item_count|((item_count - average_items_per_merchant)**2)}
    Math.sqrt(((merch_item_count.sum) / (merch_item_count.count - 1)).to_f.round(2)).round(2)
  end

  def merchants_with_high_item_count
    std_dev = average_items_per_merchant_standard_deviation
    item_hash = @item_repository.all.group_by {|item| item.merchant_id}
    merchant_id_array = item_hash.keys.find_all {|id| @item_repository.find_all_by_merchant_id(id).count > (std_dev + average_items_per_merchant)}
    merchant_array = merchant_id_array.map {|merchant_id|@merchant_repository.find_by_id(merchant_id)}
  end

  def average_average_price_per_merchant
    counter = 0
    @merchant_repository.all.map do |merchant|
      counter += average_item_price_for_merchant(merchant.id)
    end
    (counter / @merchant_repository.all.count).floor(2)
  end

  def price_std_dev
    avg_item_price = (@item_repository.all.sum {|item| item.unit_price}/@item_repository.all.count)
    std_dev_difs = @item_repository.all.flat_map{|item|((item.unit_price - avg_item_price)**2)}
    sq_rt = Math.sqrt(((std_dev_difs.sum) / (@item_repository.all.count - 1)).to_f)
    std_dev_price = sq_rt.round(2)
  end

  def golden_items
    aappm = average_average_price_per_merchant
    psd = price_std_dev
    @item_repository.all.select do |item|
      item.unit_price > (aappm + (psd * 2))
    end
  end

  def average_invoices_per_merchant
  ((@invoice_repository.all.count.to_f / @merchant_repository.all.count.to_f).round(2))
  end

  def average_invoices_per_merchant_standard_deviation
    merchant_ids = @invoice_repository.all.group_by {|invoice| invoice.merchant_id}
    merch_array = merchant_ids.flat_map {|_,value|value.count}
    merch_invoice_count = merch_array.map {|invoice_count|((invoice_count - average_invoices_per_merchant)**2)}
    Math.sqrt(((merch_invoice_count.sum) / (merch_invoice_count.count - 1)).to_f.round(2)).round(2)
  end

  def top_merchants_by_invoice_count
    aipm = average_invoices_per_merchant
    aipmsd = average_invoices_per_merchant_standard_deviation
    @merchant_repository.all.select do |merchant|
      @invoice_repository.find_all_by_merchant_id(merchant.id).length > (aipm + (aipmsd * 2))
    end
  end

  def bottom_merchants_by_invoice_count
    aipm = average_invoices_per_merchant
    aipmsd = average_invoices_per_merchant_standard_deviation
    @merchant_repository.all.select do |merchant|
      @invoice_repository.find_all_by_merchant_id(merchant.id).length < (aipm - (aipmsd * 2))
    end
  end

  def shipped
    @invoice_repository.find_all_by_status("shipped")
  end

  def pending
    @invoice_repository.find_all_by_status("pending")
  end

  def returned
    @invoice_repository.find_all_by_status("returned")
  end

  def invoice_status(symbol)
    ship_perc = (((shipped.count.to_f / @invoice_repository.all.count).to_f) * 100).round(2)
    pending_perc = (((pending.count.to_f / @invoice_repository.all.count).to_f) * 100).round(2)
    returned_perc = (((returned.count.to_f / @invoice_repository.all.count).to_f) * 100).round(2)
    return ship_perc if symbol.to_s == "shipped"
    return pending_perc if symbol.to_s == "pending"
    return returned_perc if symbol.to_s == "returned"
  end

  def date_to_day
    invoice_days = @invoice_repository.all.map do |invoice|
      invoice.created_at = Date.parse(invoice.created_at).strftime("%A")
    end
  end

  def sunday_inv
    date_to_day.find_all{|day| day.include?("Sunday")}
  end

  def monday_inv
    date_to_day.find_all{|day| day.include?("Monday")}
  end

  def tuesday_inv
    date_to_day.find_all{|day| day.include?("Tuesday")}
  end

  def wednesday_inv
    date_to_day.find_all{|day| day.include?("Wednesday")}
  end

  def thursday_inv
    date_to_day.find_all{|day| day.include?("Thursday")}
  end

  def friday_inv
    date_to_day.find_all{|day| day.include?("Friday")}
  end

  def saturday_inv
    date_to_day.find_all{|day| day.include?("Saturday")}
  end

  def days_of_the_week
    days_of_the_week_array = []
    days_of_the_week_array.push(sunday_inv, monday_inv,tuesday_inv,wednesday_inv,thursday_inv,friday_inv, saturday_inv)
    days_of_the_week_array
  end

  def standard_deviation_invoices_per_day
    days_of_the_week

    avg_invoice_perday = @invoice_repository.all.count / 7
    squares_diffs = days_of_the_week.map {|day|((day.count - avg_invoice_perday)**2)}
    Math.sqrt((squares_diffs.sum/6).to_f.round(2)).round(2)
  end

  def top_days_by_invoice_count
    avg_invoice_perday = @invoice_repository.all.count / 7
    sdipd = standard_deviation_invoices_per_day
    high_invoice_days = days_of_the_week.select do |invoice|
      invoice.count > (avg_invoice_perday + (sdipd * 1))
    end
    high_invoice_days.flatten.uniq
  end
end
