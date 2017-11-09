module MerchantAnalytics

  def average_items_per_merchant
    merchant_count = @sales_engine.merchants.all.length
    item_count = @sales_engine.items.all.length
    (item_count.to_f / merchant_count).round(2)
  end

  def merchant_list
    sales_engine.merchants.merchants.map { |merchant| merchant.id }
  end

  def total_merchants_minus_one
    ((sales_engine.merchants.all.count) -1)
  end

  def average_items_per_merchant_standard_deviation
    Math.sqrt(find_standard_deviation_total).round(2)
  end

  def create_merchant_id_item_total_list
    Hash[merchant_list.zip find_items]
  end

  def standard_deviation_plus_average
    @standard_dev + average_items_per_merchant
  end

  def filter_merchants_by_items_in_stock
    create_merchant_id_item_total_list.find_all do |key, value|
      value >= standard_deviation_plus_average
    end
  end

  def merchants_with_high_item_count
    filter_merchants_by_items_in_stock.map do |merchants|
    sales_engine.merchants.find_by_id(merchants[0])
    end
  end

  def average_item_price_for_merchant(merchant_id)
    list = find_the_collections_of_items(merchant_id)
    reduced = list.reduce(0) { |sum, item| sum + item.unit_price }
    (reduced / list.count).round(2)
  end

  def find_the_collections_of_items(merchant_id)
    sales_engine.items.find_all_by_merchant_id(merchant_id)
  end

  def average_average_price_per_merchant
    (merchant_list.reduce(0) { |sum, merchant|
      sum + average_item_price_for_merchant(merchant)
      } / merchant_list.count).round(2)
  end

  def average_invoices_per_merchant
    (find_invoice_totals.reduce(0) { |sum, totals|
    sum += totals } / find_invoice_totals.count.to_f).round(2)
  end

  def find_invoice_totals
    merchant_list.map do |merchant|
      sales_engine.invoices.find_all_by_merchant_id(merchant).length
    end
  end

  def average_invoices_per_merchant_standard_deviation
    (Math.sqrt(invoice_difference_total_divided).round(2))
  end

  def invoice_count_two_standard_deviations_above_mean
    @ave_inv_per_merch + (average_invoices_per_merchant_standard_deviation * 2)
  end

  def invoice_count_two_standard_deviations_below_mean
    @ave_inv_per_merch - (average_invoices_per_merchant_standard_deviation * 2)
  end

  def top_merchants
    sum = invoice_count_two_standard_deviations_above_mean
    create_merchant_invoice_total_list.find_all do |key, value|
      key if value >= sum
    end
  end

  def top_merchants_by_invoice_count
    top_merchants.map { |item| sales_engine.merchants.find_by_id(item.first) }
  end

  def bottom_merchants
    sum = invoice_count_two_standard_deviations_below_mean
    create_merchant_invoice_total_list.find_all do |key, value|
      key if value <= sum
    end
  end

  def bottom_merchants_by_invoice_count
    bottom_merchants.map {|item| sales_engine.merchants.find_by_id(item.first)}
  end

  def create_merchant_invoice_total_list
    Hash[merchant_list.zip find_invoice_totals]
  end

  def missing_merchants
    sales_engine.merchants.all.find_all do |merchant|
      merchant.valid_invoices.count == 0
    end
  end

  def valid_inv_grouped_by_merchant
    valid_invoices.group_by do |invoice|
      invoice.merchant_id
    end
  end

  def total_of_invoices_per_merchant
    valid_inv_grouped_by_merchant.reduce({}) do |result, pair|
      result.update pair.first => (invoice_totals(pair.last))
    end
  end

  def fill_in_missing_merchants
    merchants_by_rev = total_of_invoices_per_merchant
    missing_merchants.each do |merchant|
      merchants_by_rev[merchant.id] = 0
    end
    merchants_by_rev
  end

  def merchants_by_revenue
    fill_in_missing_merchants.sort_by do |key, value|
      value
    end.reverse
  end

  def convert_revenue_to_merchants
    merchants_by_revenue.map do |merchant_rev|
      @sales_engine.merchants.find_by_id(merchant_rev.first)
    end
  end

  def top_revenue_earners(count = 20)
    merchants = convert_revenue_to_merchants
    merchants.first(count)
  end

  def merchants_ranked_by_revenue
    convert_revenue_to_merchants
  end

  def merchants_with_only_one_item
    @sales_engine.merchants.all.find_all do |merchant|
      merchant.items.count == 1
    end
  end

  def merchants_with_invalid_invoices
    invalid_invoices.map do |invoice|
      invoice.merchant_id
    end.uniq
  end

  def merchants_with_pending_invoices
    merchants_with_invalid_invoices.map do |merchant_id|
      sales_engine.merchants.find_by_id(merchant_id)
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_with_only_one_item.find_all do |merchant|
      (merchant.created_at).strftime("%B") == month
    end
  end

  def revenue_by_merchant(id)
    invoice_totals(@sales_engine.merchants.find_by_id(id).invoices)
  end

  def valid_invoices_for_merchant(id)
    valid_invoices.find_all do |invoice|
      invoice.merchant_id == id
    end.flatten
  end

  def invoice_items_for_merchant(id)
    valid_invoices_for_merchant(id).map do |invoice|
      invoice.invoice_items
    end.flatten
  end

  def item_id_list_for_given_merchant(id)
    invoice_items_for_merchant(id).reduce({}) do |result, invoice_item|
      result[invoice_item.item_id] = invoice_item.quantity
      result
    end
  end

  def frequency_list_for_items(id)
    item_id_list_for_given_merchant(id).reduce(Hash.new(0)) do |result, item|
      result[item.first] += (1 * item.last)
      result
    end
  end

  def item_ids_for_most_sold(id)
    most_frequent_item_on_list(id).map do |pair|
      pair.first
    end
  end

  def most_sold_item_for_merchant(id)
    item_ids_for_most_sold(id).map do |id|
      sales_engine.items.find_by_id(id)
    end
  end

  def freq_of_inv_item_for_merch(id)
    invoice_items_for_merchant(id).reduce(Hash.new(0)) do |result, item|
      result[item] += 1
      result
    end
  end

  def total_of_items_sold_assigned_to_invoice_item(id)
    freq_of_inv_item_for_merch(id).reduce(Hash.new(0)) do |result,(key, value)|
      result[key] = (key.unit_price * key.quantity * value)
      result
    end
  end

  def highest_inv_item_revenue(id)
    total_of_items_sold_assigned_to_invoice_item(id).max_by do |key, value|
      value
    end
  end

  def best_item_for_merchant(id)
    @sales_engine.items.find_by_id(highest_inv_item_revenue(id).first.item_id)
  end
end
