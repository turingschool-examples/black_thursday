module MerchantAnalyst
  def average_items_per_merchant
    items_by_merchant = @items.all.group_by { |item| item.merchant_id }
    item_count = items_by_merchant.inject(0) { |sum, n| n[1].count + sum }
    (item_count.to_f / items_by_merchant.count).round(2)
  end

  def merchants_with_high_item_count
    number_set = item_count_by_merchant.map { |item_count| item_count[1] }
    mean = find_mean(number_set)
    std = standard_deviation(number_set)
    merchant_and_ave = item_count_by_merchant.find_all { |merchant| merchant[1] > std + mean }
    merchant_and_ave.map { |m_a| @merchants.find_by_id(m_a[0])}
  end

  def average_average_price_per_merchant
    find_mean(average_price_per_merchant).round(2)
  end

  def average_price_per_merchant
    items_by_merchant.map do |items|
      sum(items[1].map { |also_item| also_item.unit_price }) /items[1].count
    end
  end

  def top_merchants_by_invoice_count
    top_merchs_w_invoices = invoices_for_merchants.find_all do |merchant, invoices|
      invoices.count > average_invoices_per_merchant + 2 * average_invoices_per_merchant_standard_deviation
    end
    top_merchs_w_invoices.map do |merchant_id, invoices|
      @merchants.find_by_id(merchant_id)
    end
  end

  def bottom_merchants_by_invoice_count
    top_merchs_w_invoices = invoices_for_merchants.find_all do |merchant, invoices|
      invoices.count < average_invoices_per_merchant - 2 * average_invoices_per_merchant_standard_deviation
    end
    top_merchs_w_invoices.map do |merchant_id, invoices|
      @merchants.find_by_id(merchant_id)
    end
  end

  def merchants_with_pending_invoices
    merchants_and_invoices.map do |merchant, invoices|
     merchant
    end
  end

  def merchants_and_invoices
    pending_invoices.group_by do |invoice|
      @merchants.find_by_id(invoice.merchant_id)
    end
  end

  def pending_invoices
    @invoices.all.reject do |invoice|
      min_one_transaction_passed(invoice)
    end
  end

  def revenue_by_merchant(merchant_id)
    merchant_invoices = @invoices.all.select { |invoice| invoice.merchant_id == merchant_id }
    merchant_invoices = merchant_invoices.select do |invoice|
      min_one_transaction_passed(invoice)
    end
    all_invoice_items_by_merchant = merchant_invoices.map do |invoice|
      @invoice_items.find_all_by_invoice_id(invoice.id)
    end.flatten
    all_invoice_items_by_merchant.reduce(0) do |sum, ii|
      ii.quantity * ii.unit_price + sum
    end.round(2)
  end

  def top_revenue_earners(x = 20)
    rev = @merchants.all.map { |merchant| [revenue_by_merchant(merchant.id), merchant] }
    revenue_array = rev.sort_by { |revenue,merchant| revenue }
    top = revenue_array.max_by(x) { |revenue, merch| revenue }
    top.map { |revenue, merchant| merchant }
  end

  def merchants_ranked_by_revenue
    top_revenue_earners(@merchants.all.count)
  end

end
