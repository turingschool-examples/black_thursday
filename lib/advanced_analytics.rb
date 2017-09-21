module AdvancedAnalytics

  def top_revenue_earners(n = 20)
    merchants_ranked_by_revenue[0,n]
  end

  def merchants_ranked_by_revenue
    se.merchants.merchants.sort_by do |merchant|
      merchant_revenue(merchant)
    end.reverse
  end

  def merchant_revenue(merchant)
    revenue= 0.00
    merchant.invoices.each do |invoice|
      revenue += invoice.total if invoice.is_paid_in_full?
    end
    revenue
  end

  def merchants_with_pending_invoices
    se.merchants.all.select do |merchant|
      merchant.invoices.any? do |invoice|
        invoice.transactions.all? do |transaction|
          transaction.result == 'failed'
        end
      end
    end
  end

  def merchants_with_only_one_item_registered_in_month(month_name)
    merchants = merchants_with_only_one_item
    one_item_merchants_by_month = merchants.group_by do |merchant|
      merchant.created_at.strftime('%B')
    end
    one_item_merchants_by_month[month_name]
  end

  def item_in_month?(merchant, month_name)
    items_in_month = merchant.items.select do |item|
      item.created_at.strftime('%B') == month_name
    end
    items_in_month.length == 1
  end

  def merchant_by_month_created
    se.merchants.all.group_by do |merchant|
      merchant.created_at.strftime('%B')
    end
  end

  def merchants_with_only_one_item
    se.merchants.all.select do |merchant|
      merchant.items.count == 1
    end
  end

  def revenue_by_merchant(merchant_id)
    merchant = se.merchants.find_by_id(merchant_id)
    revenue = merchant_revenue(merchant)
    BigDecimal.new(revenue, 4)
  end

  def paid_invoices(merchant)
    merchant.invoices.select do |invoice|
      invoice.is_paid_in_full?
    end
  end

  def paid_invoice_items(paid_invoices)
    paid_invoices.map do |invoice|
      invoice.invoice_items
    end.flatten
  end


  def item_id_with_invoice_items(invoice_items)
    invoice_items.group_by do |invoice_item|
      invoice_item.item_id
    end
  end

  def total_sold_for_item(item_id_with_invoice_items)
    item_id_with_invoice_items.each do |k, v|
      total_sold = v.reduce(0) do |sum, invoice_item|
        sum + invoice_item.quantity
      end
      item_id_with_invoice_items[k] = total_sold
    end
    item_id_with_invoice_items
  end

  def total_revenue_for_item(item_id_with_invoice_items)
    item_id_with_invoice_items.each do |k, v|
      total_sold = v.reduce(0) do |sum, invoice_item|
        sum + invoice_item.quantity * invoice_item.unit_price
      end
      item_id_with_invoice_items[k] = total_sold
    end
    item_id_with_invoice_items
  end

  def find_max_value(items_sold_hash)
    items_sold_hash.values.max
  end

  def find_items_with_max_value(items_sold_hash)
    max_num_sold = find_max_value(items_sold_hash)
    item_ids = []
    items_sold_hash.each do |item_id, num|
      if num == max_num_sold
        item_ids << item_id
      end
    end
    item_ids
  end

  def find_items_by_id(item_id_array)
    most_sold_items = []
    if item_id_array.class == Integer
      most_sold_items << se.items.find_by_id(item_id_array)
    else
      item_id_array.each do |item_id|
        most_sold_items << se.items.find_by_id(item_id)
      end
    end
    most_sold_items
  end

  def most_sold_item_for_merchant(merchant_id)
    merchant = se.merchants.find_by_id(merchant_id)
    paid_invoices = paid_invoices(merchant)
    invoice_items = paid_invoice_items(paid_invoices)
    sorted_invoice_items = item_id_with_invoice_items(invoice_items)
    sold_items = total_sold_for_item(sorted_invoice_items)
    most_sold_items_by_id = find_items_with_max_value(sold_items)
    find_items_by_id(most_sold_items_by_id)
  end

  def best_item_for_merchant(merchant_id)
    merchant = se.merchants.find_by_id(merchant_id)
    paid_invoices = paid_invoices(merchant)
    invoice_items = paid_invoice_items(paid_invoices)
    sorted_invoice_items = item_id_with_invoice_items(invoice_items)
    item_revenues = total_revenue_for_item(sorted_invoice_items)
    most_sold_items_by_id = find_items_with_max_value(item_revenues)
    find_items_by_id(most_sold_items_by_id).first
  end

end
