module MerchantAnalyst

  def calculate_total_revenue(invoice_list)
    invoice_list.reduce(0) do |total_revenue, invoice|
      total_revenue + invoice.total
    end
  end

  def total_revenue_by_date(date)
    invoices_by_date = @engine.invoices.find_all_by_date(date)
    calculate_total_revenue(invoices_by_date)
  end

  def revenue_by_merchant(merchant_id)
    merchant_invoices = @engine.invoices.find_all_by_merchant_id(merchant_id)
    merchant_invoice_revenues = merchant_invoices.map do |merchant_invoice|
      merchant_invoice.total
    end
    merchant_invoice_revenues.compact.sum
  end

  def total_revenue_for_all_merchants
    revenue_per_invoice = Hash[@engine.invoice_list.map {|invoice| [invoice.merchant_id, revenue_by_merchant(invoice.merchant_id)]}]
  end

  def merchants_ranked_by_revenue
    sorted_merchants = total_revenue_for_all_merchants.sort_by {|key, value| value}.to_h
    sorted_merchants.keys.reverse.map {|merchant_id| @engine.merchants.find_by_id(merchant_id)}
  end

  def top_revenue_earners(x = 20)
    merchants_ranked_by_revenue.first(x)
  end

  def merchants_with_pending_invoices
    @engine.merchant_list.find_all {|merchant| merchant.pending_invoices?}
  end

  def collect_item_merchant_ids
    item_merchant_ids = @engine.item_list.map do |item|
      item.merchant_id
    end
  end

  def find_merchant_ids_with_only_one_item
    item_merchant_ids = collect_item_merchant_ids
    one_item_merchant_ids = []
    item_merchant_ids.each do |merchant_id|
      if item_merchant_ids.count(merchant_id) == 1
        one_item_merchant_ids << merchant_id
      end
    end
    one_item_merchant_ids
  end

  def merchants_with_only_one_item
    one_item_merchant_ids = find_merchant_ids_with_only_one_item
    one_item_merchant_ids.map do |merchant_id|
      @engine.merchants.find_by_id(merchant_id)
    end
  end

  def merchants_with_only_one_item_registered_in_month(month_name)
    month_index = Date::MONTHNAMES.index(month_name)
    one_item_merchants = merchants_with_only_one_item
    one_item_merchants.find_all {|merchant| merchant.created_at.month == month_index}
  end

  def most_sold_item_for_merchant(merchant_id)
    merchant_invoices = @engine.invoices.find_all_by_merchant_id(merchant_id)
    invoice_ids = merchant_invoices.map {|invoice| invoice.id if invoice.is_paid_in_full?}
    invoice_items = invoice_ids.map do |invoice_id|
      @engine.invoice_items.find_all_by_invoice_id(invoice_id)
    end
    sorted_invoice_items = invoice_items.flatten.sort_by {|invoice_item| invoice_item.quantity}
    max_invoice_items = sorted_invoice_items.find_all {|invoice_item| invoice_item.quantity == sorted_invoice_items[-1].quantity}
    max_item_ids = max_invoice_items.map {|invoice_item| invoice_item.item_id}
    most_sold_items = max_item_ids.map {|item_id| @engine.items.find_by_id(item_id)}
  end

  def best_item_for_merchant(merchant_id)
    merchant_invoices = @engine.invoices.find_all_by_merchant_id(merchant_id)
    invoice_ids = merchant_invoices.map {|invoice| invoice.id if invoice.is_paid_in_full?}
    invoice_items = invoice_ids.map do |invoice_id|
      @engine.invoice_items.find_all_by_invoice_id(invoice_id)
    end
    item_revenues = Hash[invoice_items.flatten.map{|invoice_item| [invoice_item.item_id, invoice_item.quantity * invoice_item.unit_price]}]
    best_item_id = item_revenues.max_by{|item_id,revenue| revenue}[0]
    @engine.items.find_by_id(best_item_id)
  end


end
