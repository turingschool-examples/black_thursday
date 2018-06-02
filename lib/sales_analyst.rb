require 'date'

class SalesAnalyst

  def initialize(parent)
    @parent = parent
  end

  def average_items_per_merchant
    total_items = items_per_merchant.inject(0.0){|sum, item_count| sum += item_count}
    (total_items / items_per_merchant.count).round(2)
  end

  def items_per_merchant
    items_by_merchant_id.map {|merchant_id, items| items.count}
  end

  def items_by_merchant_id
    @parent.items.all.group_by {|item| item.merchant_id}
  end

  def average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant
    sum_of_squares = items_per_merchant.inject(0.0) {|sum, items| ((items - mean) ** 2) + sum }
    divided = sum_of_squares / (items_per_merchant.count - 1)
    Math.sqrt(divided).round(2)
  end

  def merchants_with_high_item_count
    one_sd_above = average_items_per_merchant + average_items_per_merchant_standard_deviation
    merchant_ids = items_by_merchant_id.map do |merch_id, items|
      merch_id if items.count > one_sd_above
    end.compact
    merchant_ids.map {|id| @parent.merchants.find_by_id(id)}
  end

  def average_item_price_for_merchant(merchant_id)
    items = @parent.items.find_all_by_merchant_id(merchant_id)
    (items.inject(0) {|sum, item| sum += item.unit_price} / items.count).round(2)
  end

  def average_average_price_per_merchant
  merchant_ids = items_by_merchant_id.keys
  (merchant_ids.inject(0) {|sum, id| sum += average_item_price_for_merchant(id)} / merchant_ids.count).round(2)
  end

  def item_price_std_dev
    mean = average_average_price_per_merchant
    sum_of_squares = @parent.items.all.inject(0.0) {|sum, item| ((item.unit_price - mean) ** 2) + sum }
    divided = sum_of_squares / (@parent.items.all.count - 1)
    Math.sqrt(divided).round(2)
  end

  def golden_items
    two_sd_above = average_average_price_per_merchant + (item_price_std_dev * 2)
    @parent.items.all.find_all {|item| item.unit_price > two_sd_above}
  end

  def average_invoices_per_merchant
    total_invoices = invoices_per_merchant.inject(0.0){|sum, invoice_count| sum += invoice_count}
    (total_invoices / invoices_per_merchant.count).round(2)
  end

  def invoices_per_merchant
    invoices_by_merchant_id.map {|merchant_id, invoices| invoices.count}
  end

  def invoices_by_merchant_id
    @parent.invoices.all.group_by {|invoice| invoice.merchant_id}
  end

  def average_invoices_per_merchant_standard_deviation
    mean = average_invoices_per_merchant
    sum_of_squares = invoices_per_merchant.inject(0.0) {|sum, invoices| ((invoices - mean) ** 2) + sum }
    divided = sum_of_squares / (invoices_per_merchant.count - 1)
    Math.sqrt(divided).round(2)
  end

  def top_merchants_by_invoice_count
    two_sd_above = average_invoices_per_merchant + (average_invoices_per_merchant_standard_deviation * 2)
    merchant_ids = invoices_by_merchant_id.map do |merch_id, invoices|
      merch_id if invoices.count > two_sd_above
    end.compact
    merchant_ids.map {|id| @parent.merchants.find_by_id(id)}
  end

  def bottom_merchants_by_invoice_count
    two_sd_below = average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2)
    merchant_ids = invoices_by_merchant_id.map do |merch_id, invoices|
      merch_id if invoices.count < two_sd_below
    end.compact
    merchant_ids.map {|id| @parent.merchants.find_by_id(id)}
  end

  def top_days_by_invoice_count
    one_sd_above = invoice_per_day_of_week_std_deviation + invoice_mean_for_day_of_week
    invoices_per_day_of_week.map do |day, invoices|
      day if invoices.count > one_sd_above
    end.compact
  end

  def invoice_mean_for_day_of_week
    @parent.invoices.all.count / 7
  end

  def invoice_per_day_of_week_std_deviation
    mean = invoice_mean_for_day_of_week
    sum_of_squares = invoice_counts_per_day_of_week.inject(0.0) { |sum, count| ((count - mean) ** 2) + sum }
    divided = sum_of_squares / (invoice_counts_per_day_of_week.count - 1)
    Math.sqrt(divided).round(2)
  end

  def invoices_per_day_of_week
    @parent.invoices.all.group_by {|invoice| invoice.created_day_of_week}
  end

  def invoice_counts_per_day_of_week
    invoices_per_day_of_week.map {|day, invoices| invoices.count}
  end

  def invoice_status(status)
    status = @parent.invoices.find_all_by_status(status)
    ((status.count.to_f / @parent.invoices.all.count) * 100).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    transactions = @parent.transactions.find_all_by_invoice_id(invoice_id)
    transactions.any? {|transaction| transaction.result == :success}
  end

  def invoice_total(invoice_id)
    return 0 if !(invoice_paid_in_full?(invoice_id))
    invoice_items = @parent.invoice_items.find_all_by_invoice_id(invoice_id)
    invoice_items.inject(0.0) {|sum, invoice_item| sum + (invoice_item.unit_price * invoice_item.quantity)}
  end

  def group_invoices_by_customer_id
    @parent.invoices.all.group_by {|invoice| invoice.customer_id}
  end

  def top_buyers(selected = 20)
    new_hash = {}
    group_invoices_by_customer_id.each do |cust_id, invoices|
          new_hash[cust_id] = invoices.inject(0) {|sum, invoice| sum + invoice_total(invoice.id)}
    end
    arr_of_arr = new_hash.sort_by {|cust_id, total| total }
    customer_ids = (arr_of_arr.map {|arr| arr[0]}).reverse.take(selected)
    customer_ids.map {|id| @parent.customers.find_by_id(id)}
  end

  def mode(array)
    a = array.group_by {|num| num}
    a.max_by {|key, value| value.count}.flatten.uniq[0]
  end

  def top_merchant_for_customer(customer_id)
    invoices = @parent.invoices.find_all_by_customer_id(customer_id)
    invoice_totals = invoices.map {|invoice| invoice_total(invoice.id)}
    merchant_ids = invoices.map {|invoice| invoice.merchant_id}
    merch_totals = {}
    merchant_ids.each_with_index do |id, index|
      if merch_totals[id] == nil
        merch_totals[id] = invoice_totals[index]
      else
        merch_totals[id] += invoice_totals[index]
      end
    end
    top_merch_id = merch_totals.max_by {|id, total| total}[0]
    @parent.merchants.find_by_id(top_merch_id)
  end

  def one_time_buyers
    invoices = @parent.invoices.all
    merchant_ids = invoices.map {|invoice| invoice.merchant_id}
    customer_ids = invoices.map {|invoice| invoice.customer_id}
    customers_per_merch ={}
    customer_ids.each_with_index do |cust_id, index|
      if customers_per_merch[cust_id] == nil
         customers_per_merch[cust_id] = [merchant_ids[index]]
      else
        customers_per_merch[cust_id] << merchant_ids[index]
      end
    end
    one_time_buyers = customers_per_merch.find_all {|cust_id, merch_ids| merch_ids.length == 1}
    one_time_customer_ids = one_time_buyers.map {|cust_per_merch| cust_per_merch[0]}
    one_time_customer_ids.map {|cust_id| @parent.customers.find_by_id(cust_id)}
  end
end
