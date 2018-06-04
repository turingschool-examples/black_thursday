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
    sum_of_squares = items_per_merchant.inject(0.0) do |sum, items|
      ((items - mean) ** 2) + sum
    end / (items_per_merchant.count - 1)
    Math.sqrt(sum_of_squares).round(2)
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
    average_item_price = items.inject(0) do |sum, item|
      sum += item.unit_price
    end / items.count
    average_item_price.round(2)
  end

  def average_average_price_per_merchant
  merchant_ids = items_by_merchant_id.keys
  average_average_price = merchant_ids.inject(0) do |sum, id|
    sum += average_item_price_for_merchant(id)
  end / merchant_ids.count
  average_average_price.round(2)
  end

  def item_price_std_dev
    mean = average_average_price_per_merchant
    sum_of_squares = @parent.items.all.inject(0.0) do |sum, item|
      ((item.unit_price - mean) ** 2) + sum
    end / (@parent.items.all.count - 1)
    Math.sqrt(sum_of_squares).round(2)
  end

  def golden_items
    two_sd_above = average_average_price_per_merchant + (item_price_std_dev * 2)
    @parent.items.all.find_all {|item| item.unit_price > two_sd_above}
  end

  def average_invoices_per_merchant
    total_invoices = invoices_per_merchant.inject(0.0) do |sum, invoice_count|
      sum += invoice_count
    end
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
    sum_of_squares = invoices_per_merchant.inject(0.0) do |sum, invoices|
      ((invoices - mean) ** 2) + sum
    end / (invoices_per_merchant.count - 1)
    Math.sqrt(sum_of_squares).round(2)
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
    sum_of_squares = invoice_counts_per_day_of_week.inject(0.0) do |sum, count|
       ((count - mean) ** 2) + sum
    end / (invoice_counts_per_day_of_week.count - 1)
    Math.sqrt(sum_of_squares).round(2)
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
    invoice_items.inject(0.0) do |sum, invoice_item|
      sum + (invoice_item.unit_price * invoice_item.quantity)
    end
  end

  def group_invoices_by_customer_id
    @parent.invoices.all.group_by {|invoice| invoice.customer_id}
  end

  def top_buyers(selected = 20)
    new_hash = {}
    group_invoices_by_customer_id.each do |cust_id, invoices|
          new_hash[cust_id] = invoices.inject(0) {|sum, invoice| sum + invoice_total(invoice.id)}
    end
    cust_ids_sorted_by_total = Hash[new_hash.sort_by {|cust_id, total| total }]
    customer_ids = (cust_ids_sorted_by_total.map {|arr| arr[0]}).reverse.take(selected)
    customer_ids.map {|id| @parent.customers.find_by_id(id)}
  end

  def invoice_totals_for_customer_id(customer_id)
    invoices = @parent.invoices.find_all_by_customer_id(customer_id)
    invoices.map {|invoice| invoice_total(invoice.id)}
  end

  def merchant_ids_for_customer(customer_id)
    invoices = @parent.invoices.find_all_by_customer_id(customer_id)
    invoices.map {|invoice| invoice.merchant_id}
  end

  def merchant_totals_per_customer(invoice_totals, merchant_ids)
    merch_totals = {}
    merchant_ids.each_with_index do |id, index|
      merch_totals[id] = invoice_totals[index] if merch_totals[id] == nil
      merch_totals[id] += invoice_totals[index] if merch_totals[id] != nil
    end
    merch_totals
  end

  def top_merchant_for_customer(customer_id)
    invoice_totals = invoice_totals_for_customer_id(customer_id)
    merchant_ids = merchant_ids_for_customer(customer_id)
    merch_totals = merchant_totals_per_customer(invoice_totals, merchant_ids)
    top_merch_id = merch_totals.max_by {|id, total| total}[0]
    @parent.merchants.find_by_id(top_merch_id)
  end

  def all_merchant_ids_with_invoices
    invoices = @parent.invoices.all
    merchant_ids = invoices.map {|invoice| invoice.merchant_id}
  end

  def all_customer_ids_with_invoices
    invoices = @parent.invoices.all
    customer_ids = invoices.map {|invoice| invoice.customer_id}
  end

  def one_time_customer_ids
    merch_ids = all_customer_ids_with_invoices
    customer_ids = all_customer_ids_with_invoices
    merchs_per_cust = merchant_ids_per_customer_id(merch_ids, customer_ids)
    cust = merchs_per_cust.find_all {|cust_id, merch_ids| merch_ids.length == 1}
    cust.map {|cust_per_merch| cust_per_merch[0]}
  end

  def merchant_ids_per_customer_id(merchant_ids, customer_ids)
    customers_per_merch = {}
    customer_ids.each_with_index do |cust_id, index|
      if customers_per_merch[cust_id] == nil
         customers_per_merch[cust_id] = [merchant_ids[index]]
      else
        customers_per_merch[cust_id].push(merchant_ids[index])
      end
    end
    customers_per_merch
  end

  def one_time_buyers
    one_time_customer_ids.map {|cust_id| @parent.customers.find_by_id(cust_id)}
  end

  def quantity_per_item_id(invoice_items)
      invoice_items.inject(Hash.new(0)) do |hash, invoice_item|
      hash[invoice_item.item_id] += invoice_item.quantity
      hash
    end
  end

  def delete_unpaid(one_time_invoices)
    one_time_invoices.delete_if {|invoice| !(invoice_paid_in_full?(invoice.id))}
  end

  def one_time_invoices
    one_time_customer_ids.map do |cust_id|
      @parent.invoices.find_all_by_customer_id(cust_id)
    end.flatten
  end

  def max_quantity_invoice_item_id(invoice_items)
    quantity_per_item_id(invoice_items).max_by {|itm_id, quantity| quantity}[0]
  end

  def one_time_buyers_top_item
    paid_one_time_invoices = delete_unpaid(one_time_invoices)
    invoice_items = paid_one_time_invoices.map do |invoice|
      @parent.invoice_items.find_all_by_invoice_id(invoice.id)
    end.flatten
    @parent.items.find_by_id(max_quantity_invoice_item_id(invoice_items))
  end

  def invoices_from_invoice_ids_per_year(invoices_by_year)
    invoices_by_year.map do |invoice|
      @parent.invoice_items.find_all_by_invoice_id(invoice.id)
    end.flatten
  end

  def invoice_items_for_year(customer_id, year)
    invoices = @parent.invoices.find_all_by_customer_id(customer_id)
    invoices_by_year = invoices.find_all do |invoice|
      invoice.created_at.year == year
    end
    invoices_from_invoice_ids_per_year(invoices_by_year)
  end


  def items_bought_in_year(customer_id, year)
    invoice_items = invoice_items_for_year(customer_id, year)
    item_ids_for_year = invoice_items.map {|invoice_item| invoice_item.item_id}.uniq
    item_ids_for_year.map {|item_id| @parent.items.find_by_id(item_id)}
  end

  def highest_volume_items(customer_id)
    invoices = @parent.invoices.find_all_by_customer_id(customer_id)
    invoice_items = invoices.map {|invoice| @parent.invoice_items.find_all_by_invoice_id(invoice.id)}.flatten
    quantity_per_item_id = invoice_items.inject(Hash.new(0)) do |hash, invoice_item|
      hash[invoice_item.item_id] += invoice_item.quantity
      hash
    end
    sorted_items = quantity_per_item_id.sort_by {|item_id, quantity| quantity}
    highest_quantity = sorted_items[-1][1]
    item_ids = quantity_per_item_id.to_a.find_all {|item_quantity_pair| item_quantity_pair[0] if item_quantity_pair[1] == highest_quantity}
    item_ids.map {|item_id| @parent.items.find_by_id(item_id[0])}
  end

  def customers_with_unpaid_invoices
    unpaid_invoices = @parent.invoices.all.find_all do |invoice|
      !(invoice_paid_in_full?(invoice.id))
    end
    unpaid_customer_ids = unpaid_invoices.map {|invoice| invoice.customer_id}
    unpaid_customer_ids.map {|cust_id| @parent.customers.find_by_id(cust_id)}.uniq
  end

  def best_invoice_by_revenue
    invoices = @parent.invoices.all
    paid_invoices = invoices.delete_if {|invoice| !(invoice_paid_in_full?(invoice.id))}
    invoice_items = paid_invoices.map {|invoice| @parent.invoice_items.find_all_by_invoice_id(invoice.id)}.flatten
    invoice_ids_and_totals = invoice_items.inject(Hash.new(0)) do |hash, invoice_item|
      hash[invoice_item.invoice_id] += (invoice_item.quantity * invoice_item.unit_price)
      hash
    end
    best_invoice_id = invoice_ids_and_totals.max_by {|inv_id, total| total}[0]
    @parent.invoices.find_by_id(best_invoice_id)
  end

  def best_invoice_by_quantity
    invoices = @parent.invoices.all
    paid_invoices = invoices.delete_if {|invoice| !(invoice_paid_in_full?(invoice.id))}
    invoice_items = paid_invoices.map {|invoice| @parent.invoice_items.find_all_by_invoice_id(invoice.id)}.flatten
    invoice_ids_and_totals = invoice_items.inject(Hash.new(0)) do |hash, invoice_item|
      hash[invoice_item.invoice_id] += invoice_item.quantity
      hash
    end
    best_invoice_id = invoice_ids_and_totals.max_by {|inv_id, total| total}[0]
    @parent.invoices.find_by_id(best_invoice_id)
  end
end
