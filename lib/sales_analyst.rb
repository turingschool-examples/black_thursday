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

  def initialize(args)
    @item_repo = args[:items]
    @merchant_repo = args[:merchants]
    @invoice_repo = args[:invoices]
    @invoice_item_repo = args[:invoice_items]
    @transaction_repo = args[:transactions]
    @customer_repo = args[:customers]
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

  def average_items_per_merchant_standard_deviation
    per_merchant_standard_deviation(@item_repo)
  end

  def average_items_per_merchant
    average_items_invoices_per_merchant(@item_repo)
  end

  def average_invoices_per_merchant
    average_items_invoices_per_merchant(@invoice_repo)
  end

  def average_invoices_per_merchant_standard_deviation
    per_merchant_standard_deviation(@invoice_repo)
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


  def top_days_by_invoice_count
    average = @invoice_repo.all.count/7
    grouped_by_weekday = @invoice_repo.all.group_by do |invoice|
      invoice.created_at.wday
    end
    invoices_by_day = grouped_by_weekday.values.map do |invoice_collection|
      invoice_collection.count
    end
    day_nums = grouped_by_weekday.find_all do |weekday, invoices|
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
    trans_id_list = group_transaction_by_invoice(search_invoice_id)
    return false if trans_id_list == []
    if trans_id_list != []
      trans_id_list.any? do |trans|
        trans.result == :success
      end
    end
  end

  def invoice_pending?(search_invoice_id)
    trans_id_list = group_transaction_by_invoice(search_invoice_id)
    return true if trans_id_list == []
    if trans_id_list != []
      trans_id_list.all? do |trans|
        trans.result == :failed
      end
    end
  end

  def group_transaction_by_invoice(search_invoice_id)
    @transaction_repo.all.find_all do |transaction|
      transaction.invoice_id == search_invoice_id
    end
  end

  def invoice_total(search_invoice_id)
    invoices_list = @invoice_item_repo.all.find_all do |i|
      i.invoice_id == search_invoice_id
    end
    invoices_list.reduce(BigDecimal(0,10)) do |sum, i|
      (i.quantity * i.unit_price) + sum
    end
  end

  def total_revenue_by_date(date)
    found_invoices = @invoice_repo.all.find_all do |invoice|
      invoice.created_at.strftime('%F') == date.strftime('%F')
    end
    invoice_totals = found_invoices.map do |invoice|
      invoice_total(invoice.id)
    end
    sum(invoice_totals)
  end

  def merchants_with_pending_invoices
    hash = merchant_hash(@invoice_repo)
    pending_merchants = hash.find_all do |merchant, invoices|
      invoices.any? do |invoice|
        invoice_pending?(invoice.id)
      end
    end
    pending_merchants.map do |merchant|
      merchant[0]
    end
  end

  def revenue_by_merchant(search_merchant_id)
    merchant_paid_invoices = find_valid_invoices_by_merchant(search_merchant_id)
    merchant_paid_invoices.reduce(0) do |sum, invoice|
      invoice_total(invoice.id) + sum
    end
  end

  def find_valid_invoices_by_merchant(search_merchant_id)
    paid_invoices = @invoice_repo.all.find_all do |invoice|
      invoice_paid_in_full?(invoice.id)
    end
    paid_invoices.find_all do |invoice|
      invoice.merchant_id == search_merchant_id
    end
  end

  def top_revenue_earners(number=20)
    merchants_ranked_by_revenue[0..(number-1)]
  end

  def merchants_ranked_by_revenue
    @merchant_repo.all.sort_by do |merchant|
      revenue_by_merchant(merchant.id)
    end.reverse
  end

  def merchants_with_only_one_item
    items_by_merchant = merchant_hash(@item_repo)
    found = items_by_merchant.find_all do |merchant,items|
      items.length == 1
    end
    found.map do |pair|
      pair[0]
    end
  end

  def merchants_with_only_one_item_registered_in_month(month_name)
    merchants_with_only_one_item.find_all do |merchant|
      merchant.created_at.month == Time.parse(month_name).month
    end
  end

  def map_invoice_to_invoice_items(invoices)
    invoices.map do |invoice|
      @invoice_item_repo.all.find_all do |i|
        i.invoice_id == invoice.id
      end
    end
  end

  def most_sold_item_for_merchant(merchant_id)
    valid_invoices = find_valid_invoices_by_merchant(merchant_id)
    invoice_items = map_invoice_to_invoice_items(valid_invoices).flatten
    grouped_by_item_id = invoice_items.group_by do |invoice|
      invoice.item_id
    end
    sorted = group_item_id_by_quantity(grouped_by_item_id)
    final = sort_pairs_by_quantity(sorted)
    final.map do |element|
      @item_repo.find_by_id(element[0])
    end
  end

  def group_item_id_by_quantity(grouped_by_item_id)
    item_quantity_array = grouped_by_item_id.map do |key, value|
      total = value.reduce(0) do |sum, invoice_item|
          sum + invoice_item.quantity
      end
      [key, total]
    end
    item_quantity_array.sort_by do |pair|
      pair[1]
    end
  end

  def sort_pairs_by_quantity(sorted)
    sorted.find_all do |pairs|
      pairs[1] == sorted[-1][1]
    end
  end

  def best_item_for_merchant(merchant_id)
    valid = find_valid_invoices_by_merchant(merchant_id)
    invoice_items = map_invoice_to_invoice_items(valid).flatten!
    grouped = invoice_items.group_by do |invoice_item|
      invoice_item.item_id
    end
    winner = sort_pairs_by_revenue(grouped).last
    @item_repo.find_by_id(winner[0])
  end

  def group_item_id_by_revenue(grouped)
    grouped.map do |key, value|
      total = value.reduce(0) do |sum, invoice_item|
          sum + (invoice_item.quantity * invoice_item.unit_price)
      end
      [key, total]
    end
  end

  def sort_pairs_by_revenue(grouped)
    item_price_array = group_item_id_by_revenue(grouped)
    item_price_array.sort_by do |pair|
      pair[1]
    end
  end
end
