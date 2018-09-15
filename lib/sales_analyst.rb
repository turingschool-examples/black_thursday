require_relative '../lib/sales_analyst'
require_relative '../lib/std_dev_module'
require 'Date'

class SalesAnalyst
  include StdDevModule

  attr_reader :item_repo,
              :merchant_repo,
              :invoice_repo,
              :invoice_item_repo,
              :transaction_repo,
              :customer_repo

  def initialize(item_repo, merchant_repo, invoice_repo, transaction_repo, invoice_item_repo, customer_repo)
    @item_repo = item_repo
    @merchant_repo = merchant_repo
    @invoice_repo = invoice_repo
    @invoice_item_repo = invoice_item_repo
    @transaction_repo = transaction_repo
    @customer_repo = customer_repo
  end

  def merchant_hash(repo)
    return_hash = {}
    @merchant_repo.all.each do |merchant|
      return_hash[merchant] = repo.all.find_all do |element|
        merchant.id == element.merchant_id
      end
    end
    return_hash
  end

  def merchants_with_high_item_count_hash
    merchant_hash(@item_repo).find_all do |key, value|
      value.length >= per_merchant_standard_deviation(@item_repo) + average_items_invoices_per_merchant(@item_repo)
    end.to_h
  end

  def average_items_per_merchant
    average_items_invoices_per_merchant(@item_repo)
  end

  def average_invoices_per_merchant
    average_items_invoices_per_merchant(@invoice_repo)
  end

  def merchants_with_high_item_count
    merchants_with_high_item_count_hash.keys
  end

  def average_item_price_for_merchant(search_id)
    merchant_array = merchant_hash(@item_repo).find do |merchant, items|
      merchant.id == search_id
    end
    bd_array = merchant_array[1].map do |item|
      item.unit_price
    end
    (sum(bd_array)/bd_array.length).round(2)
  end

  def average_average_price_per_merchant
    array = []
    merchant_hash(@item_repo).each do |key, value|
      array << average_item_price_for_merchant(key.id)
    end
    (sum(array)/array.length).round(2)
  end

  def average_items_per_merchant_standard_deviation
    per_merchant_standard_deviation(@item_repo)
  end

  def golden_items
    dev = calculate_std_dev_for_items
    @item_repo.all.find_all do |item|
      item.unit_price >= dev*2
    end
  end

  def top_merchants_by_invoice_count
    dev = per_merchant_standard_deviation(@invoice_repo)
    merchant_hash(@invoice_repo).find_all do |key, value|
      value.length >= dev*2 + average_items_invoices_per_merchant(@invoice_repo)
    end.to_h.keys
  end

  def bottom_merchants_by_invoice_count
    dev = per_merchant_standard_deviation(@invoice_repo)
    merchant_hash(@invoice_repo).find_all do |key, value|
      value.length <= average_items_invoices_per_merchant(@invoice_repo) - dev*2
    end.to_h.keys
  end

#stand deviation for item price
  def calculate_average_item_price
    prices = @item_repo.all.map do |item|
      item.unit_price
    end
    sum(prices)/@item_repo.all.length
  end

  def subtract_square_sum_array_for_unit_price
    set = @item_repo.all
    mean = calculate_average_item_price
    new_set = set.map do |element|
      (mean - element.unit_price)**2
    end
    sum(new_set)
  end

  def calculate_std_dev_for_items
    step_one = subtract_square_sum_array_for_unit_price
    step_two = step_one/(@item_repo.all.count - 1)
    Math.sqrt(step_two).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    per_merchant_standard_deviation(@invoice_repo)
  end

  def top_days_by_invoice_count
    average = @invoice_repo.all.count/7
    grouped_by_weekday = @invoice_repo.all.group_by do |invoice|
      invoice.created_at.wday
    end
    invoices_by_day = grouped_by_weekday.values.map do |invoice_collection|
      invoice_collection.count
    end
    a = day_nums = grouped_by_weekday.find_all do |weekday, invoices|
      invoices.count >= average + standard_deviation(invoices_by_day)
    end.to_h.keys
    day_nums.map do |daynumber|
      Date::DAYNAMES[daynumber]
    end
  end

  def invoice_status(status_sym)
    status = status_sym
    grouped_by_status = @invoice_repo.all.group_by do |invoice|
      invoice.status
    end
    (((grouped_by_status[status].count.to_f)/(@invoice_repo.all.count)) * 100).round(2)
  end

  def invoice_paid_in_full?(search_invoice_id)
    trans_id_list = @transaction_repo.all.find_all do |transaction|
      transaction.invoice_id == search_invoice_id
    end
    return false if trans_id_list == []
    if trans_id_list != []
      trans_id_list.all? do |trans|
      trans.result == :success
      end
    end
  end

  def invoice_total(search_invoice_id)
    invoices_list = @invoice_item_repo.all.find_all do |i|
      i.invoice_id == search_invoice_id
    end
    invoices_list.reduce(BigDecimal(0)) do |sum, i|
      (i.quantity * i.unit_price) + sum
    end
  end

  def total_revenue_by_date(date)
    found_invoices = @invoice_repo.all.find_all do |invoice|
      invoice.created_at.strftime("%F") == date.strftime("%F")
    end
    invoice_totals = found_invoices.map do |invoice|
      invoice_total(invoice.id)
    end
    sum(invoice_totals)
  end
end
