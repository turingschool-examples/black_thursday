module MerchantAnalyst

  def average_items_per_merchant
    (total_items/total_merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    calculate_std_dev
  end

  def find_items_per_merchant
    pull_all_merchant_ids.map do |merchant_id|
      items.find_all_by_merchant_id(merchant_id).count
    end
  end

  def calculate_std_dev
    sum = find_items_per_merchant.reduce(0) {|result, merchant|
      squared_difference = (average_items_per_merchant - merchant) ** 2
      result + squared_difference}
    Math.sqrt(sum / (total_merchants-1)).round(2)
  end

  def merchants_and_item_count
    Hash[pull_all_merchant_ids.zip find_items_per_merchant]
  end

  def merchants_with_high_item_count
    high_item_count_merchant_ids.map do |merchant_id|
      merchants.find_by_id(merchant_id)
    end
  end

  def high_item_count_merchant_ids
    merchants_and_item_count.map do |merchant_id,item_count|
      merchant_id if item_count >
      (average_items_per_merchant + calculate_std_dev)
    end.compact
  end

  def average_item_price_for_merchant(merchant_id)
    item_prices = items.items.map do |item|
      item.unit_price if item.merchant_id == merchant_id
    end.compact
    (item_prices.sum/item_prices.length).round(2)
  end

  def average_average_price_per_merchant
    average_price = merchants.all.reduce(0) do |result,merchant|
      result += average_item_price_for_merchant(merchant.id)
    end/total_merchants
    average_price.round(2)
  end

  def total_revenue_by_date(date)
    find_invoices_by_date(date)
  end

  def find_invoices_by_date(date)
    invoices = @invoices.all.find_all do |invoice|
      invoice.created_at == date
    end
    find_invoice_items_by_invoice_date(invoices)
  end

  def find_invoice_items_by_invoice_date(invoices)
    invoice_items = invoices.map do |invoice|
      @sales_engine.find_invoice_items_by_invoice_id(invoice.id)
    end.flatten
    calculate_total_revenue_by_date(invoice_items)
  end

  def calculate_total_revenue_by_date(invoice_items)
    invoice_items.reduce(0) do |result, invoice_item|
      result += (invoice_item.quantity * invoice_item.unit_price)
    end
  end

  def revenue_by_invoice_id
    @invoice_items.all.reduce(Hash.new(0)) {|result, invoice_item|
      result[invoice_item.invoice_id] +=
      (invoice_item.quantity * invoice_item.unit_price)
      result}
  end

  def revenue_by_merchant_id
    revenue_by_invoice_id.reduce(Hash.new(0)) do |result, (invoice_id, revenue)|
      find_revenue_for_merchant_if_invoice_paid(result, invoice_id, revenue)
      result
    end
  end

  def find_revenue_for_merchant_if_invoice_paid(result, invoice_id, revenue)
    if @invoices.find_by_id(invoice_id).is_paid_in_full?
      result[@invoices.find_by_id(invoice_id).merchant_id] += revenue
    else
      result[@invoices.find_by_id(invoice_id).merchant_id] += 0
    end
  end

  def revenue_for_each_merchant
    revenue_by_merchant_id.reduce(Hash.new(0)) {|result, (merchant_id, revenue)|
      result[merchants.find_by_id(merchant_id)] += revenue
      result}
  end

  def merchants_ranked_by_revenue
    revenue_for_each_merchant.sort_by do |_, revenue|
      -revenue
    end.map(&:first)
  end

  def top_revenue_earners(amount = 20)
    merchants_ranked_by_revenue.first(amount)
  end

  def find_pending_invoices
    @invoices.all.find_all do |invoice|
      !invoice.is_paid_in_full?
    end
  end

  def find_pending_merchant_ids
    find_pending_invoices.map do |invoice|
      invoice.merchant_id
    end.uniq
  end

  def merchants_with_pending_invoices
    find_pending_merchant_ids.map do |merchant_id|
      merchants.find_by_id(merchant_id)
    end
  end

  def merchants_with_only_one_item
    merchant_ids_with_one_item.map do |merchant_id|
      merchants.find_by_id(merchant_id)
    end
  end

  def merchant_ids_with_one_item
    merchants_and_item_count.find_all do |merchant, item_count|
      item_count == 1
    end.map(&:first)
  end

  def merchants_with_only_one_item_registered_in_month(provided_month)
    merchants_with_only_one_item.find_all do |merchant|
    merchant.created_at.strftime("%B") == provided_month
    end
  end

  def revenue_by_merchant(merchant_id)
    revenue_by_merchant_id[merchant_id]
  end

  def most_sold_item_for_merchant(merchant_id)
    invoices = find_invoices_for_merchant(merchant_id)
    invoice_items = find_invoice_items_for_merchant(invoices)
    item_quantity = find_quantity_per_item(invoice_items)
    determine_most_sold_items(item_quantity)
  end

  def best_item_for_merchant(merchant_id)
    invoices = find_invoices_for_merchant(merchant_id)
    invoice_items = find_invoice_items_for_merchant(invoices)
    item_quantity = find_revenue_per_item(invoice_items)
    determine_most_sold_items(item_quantity).first
  end

  def find_invoices_for_merchant(merchant_id)
    @invoices.all.find_all do |invoice|
      invoice.is_paid_in_full? && invoice.merchant_id == merchant_id
    end
  end

  def find_invoice_items_for_merchant(invoices)
    invoices.map do |invoice|
      @invoice_items.find_all_by_invoice_id(invoice.id)
    end.flatten
  end

  def find_quantity_per_item(invoice_items)
    invoice_items.reduce(Hash.new(0)) do |result, invoice_item|
      result[items.find_by_id(invoice_item.item_id)] += invoice_item.quantity
      result
    end
  end

  def find_revenue_per_item(invoice_items)
    invoice_items.reduce(Hash.new(0)) do |result, invoice_item|
      result[items.find_by_id(invoice_item.item_id)] +=
      (invoice_item.quantity * invoice_item.unit_price)
      result
    end
  end

  def determine_most_sold_items(item_quantity)
    item_quantity.find_all do |item, quantity|
      quantity == item_quantity.values.max
    end.map(&:first)
  end


end
