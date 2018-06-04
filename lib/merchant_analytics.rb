module MerchantAnalytics
  def total_revenue_by_date(date)
    revenues_by_date = paid_invoices_by_date(date).map do |invoice|
      invoice_total(invoice.id)
    end
    sum(revenues_by_date)
  end

  def paid_invoices_by_date(date)
    @sales_engine.invoices.all.map do |invoice|
      if invoice_paid_in_full?(invoice.id) && invoice.created_at == date
        invoice
      end
    end.compact
  end

  def top_revenue_earners(amount_of_merchants = 20)
    merchants_ranked_by_revenue[0..amount_of_merchants-1]
  end

  def merchant_revenue_table
    @sales_engine.merchants.all.map do |merchant|
      [merchant.id, BigDecimal(sum(total_revenue_by_merchant(merchant.id)))]
    end.to_h
  end

  def total_revenue_by_merchant(merchant_id)
    single_merchants_invoices(merchant_id).map do |invoice|
      if invoice_paid_in_full?(invoice.id)
        invoice_total(invoice.id)
      end
    end.compact
  end

  def merchants_ranked_by_revenue
    sorted_list = merchant_revenue_table.sort_by{|merchant_id, revenue| revenue}.reverse
    sorted_list.map do |pair|
      @sales_engine.merchants.find_by_id(pair[0])
    end
  end

  def merchants_with_pending_invoices
    merchant_ids_with_pending_invoices.map do |merchant_id|
      @sales_engine.merchants.find_by_id(merchant_id)
    end
  end

  def merchant_ids_with_pending_invoices
    @sales_engine.invoices.collection.keys.map do |invoice_id|
      if !invoice_paid_in_full?(invoice_id)
        @sales_engine.invoices.find_by_id(invoice_id).merchant_id
      end
    end.compact.uniq!
  end

  def merchants_with_only_one_item
    merchants_with_only_one_item_list.map do |merchant_id|
      @sales_engine.merchants.find_by_id(merchant_id)
    end
  end

  def merchants_with_only_one_item_list
    @sales_engine.merchants.collection.keys.keep_if do |merchant_id|
      single_merchants_total_items(merchant_id) == 1
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_with_only_one_item.map do |merchant|
      if merchant.created_at.strftime("%B") == month
        merchant
      end
    end.compact
  end

  def revenue_by_merchant(merchant_id)
    sum(paid_invoice_totals_by_merchant(merchant_id))
  end

  def paid_invoice_totals_by_merchant(merchant_id)
    single_merchants_invoices(merchant_id).map do |invoice|
      if invoice_paid_in_full?(invoice.id)
        invoice_total(invoice.id)
      end
    end.compact
  end

  def most_sold_item_for_merchant(merchant_id)
    item_quantity_table = item_quantity_table_for_paid_invoices(merchant_id)
    item_quantity_table.each_with_object([]){ |(item_id, quantity), items|
      items << @sales_engine.items.find_by_id(item_id) if quantity == item_quantity_table.values.max}
  end

  def paid_invoice_items_by_merchant(merhchant_id)
    single_merchants_invoices(merhchant_id).map do |invoice|
      if invoice_paid_in_full?(invoice.id)
        @sales_engine.invoice_items.find_all_by_invoice_id(invoice.id)
      end
    end.compact.flatten
  end

  def item_quantity_table_for_paid_invoices(merchant_id)
    paid_invoice_items_by_merchant(merchant_id).inject({}) do |table, invoice_item|
      table[invoice_item.item_id] = invoice_item.quantity
      table
    end
  end

  def best_item_for_merchant(merchant_id)
    item_revenue_table = item_revenue_table_for_paid_invoices(merchant_id)
    best_item = item_revenue_table.max_by{ |item_id, revenue| revenue}
    @sales_engine.items.find_by_id(best_item[0])
  end

  def item_revenue_table_for_paid_invoices(merchant_id)
    paid_invoice_items_by_merchant(merchant_id).inject({}) do |table, invoice_item|
      table[invoice_item.item_id] = invoice_item.total_price
      table
    end
  end
end
