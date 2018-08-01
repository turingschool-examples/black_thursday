module MerchantAnalytics

  def total_revenue_by_date(date)
    invoices = find_all_invoices_by_date(date)
    invoices.inject(0) do |total, invoice|
      total + invoice_total(invoice.id) if invoice_paid_in_full?(invoice.id)
    end
  end

  def find_all_invoices_by_date(date)
    @sales_engine.invoices.all.find_all do |invoice|
      invoice.created_at.strftime('%d%m%y') == date.strftime('%d%m%y')
    end
  end

  def top_revenue_earners(number = 20)
    sorted = sort_summed_invoice_totals(number)
    sorted.map do |merchant_id, invoice_total|
      @sales_engine.merchants.find_by_id(merchant_id)
    end
  end

  def sort_summed_invoice_totals(number)
    sorted = sum_invoice_totals.sort_by {|merchant_id, sum| sum }
    sorted[-number..-1].reverse.to_h
  end

  def sum_invoice_totals
    totals = {}
    invoice_hash.each do |merchant_id, invoices|
      totals[merchant_id] = sum_invoices(invoices)
    end
    totals.delete_if {|merchant_id, sum| sum.nil?}
  end

  def sum_invoices(invoices)
    invoices.inject(0) do |sum, invoice|
      sum + invoice
    end
  end

  def invoice_hash
    earners = {}
    group_invoices_by_merchant.each do |merchant_id, invoices|
      earners[merchant_id] = pull_invoices(invoices)
    end
    earners
  end

  def pull_invoices(invoices)
    invoices.map do |invoice|
      invoice_total(invoice.id) if invoice_paid_in_full?(invoice.id)
    end.compact
  end

  def merchants_with_pending_invoices
    get_merchant_id_for_pending_invoices.map do |merchant_id|
      @sales_engine.merchants.find_by_id(merchant_id)
    end.uniq
  end

  def get_merchant_id_for_pending_invoices
    @sales_engine.invoices.all.map do |invoice|
      if !invoice_paid_in_full?(invoice.id)
        invoice.merchant_id
      end
    end.uniq.compact
  end

  def merchants_ranked_by_revenue
    sorted = sum_invoice_totals.sort_by {|merchant_id, sum| sum }
    reversed = sorted.reverse.to_h
    reversed.map do |merchant_id, invoice_total|
      @sales_engine.merchants.find_by_id(merchant_id)
    end
  end

  def get_merchant_ids_with_one_item
    items_per_merchant = {}
    group_items_by_merchant.each do |merchant_id, items|
      items_per_merchant[merchant_id] = items.count
    end
    items_per_merchant.keep_if {|id, items| items == 1}
  end

  def merchants_with_only_one_item
    get_merchant_ids_with_one_item.map do |merchant_id, items|
      @sales_engine.merchants.find_by_id(merchant_id)
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_with_only_one_item.find_all do |merchant|
      merchant.created_at.strftime('%B') == month
    end
  end

  def revenue_by_merchant(merchant_id)
    sum_invoice_totals[merchant_id]
  end

  def most_sold_item_for_merchant(merchant_id)
    paid_invoices = pull_paid_invoices_per_merchant(merchant_id)
    paid_invoice_items = find_all_paid_invoice_items_by_id(paid_invoices)
    sold_quantities = sold_invoice_item_quantities(paid_invoice_items)
    top_selling_item_by_quantity(sold_quantities)
  end

  def pull_paid_invoices_per_merchant(merchant_id)
    @sales_engine.invoices.find_all_by_merchant_id(merchant_id).find_all do |invoice|
      invoice_paid_in_full?(invoice.id)
    end
  end

  def find_all_paid_invoice_items_by_id(paid_invoices)
    paid_invoices.map do |invoice|
      @sales_engine.invoice_items.find_all_by_invoice_id(invoice.id)
    end.flatten
  end


  def sold_invoice_item_quantities(paid_invoice_items) #merchants sold item quantities
    sold_quantities = {}
    paid_invoice_items.map do |item|
      sold_quantities[item.item_id] = item.quantity
    end
    return sold_quantities
  end

  def top_selling_item_by_quantity(sold_quantities)
    top_items = []
    sold_quantities.map do |item, quantity|
      if quantity == sold_quantities.values.max
        top_items << @sales_engine.items.find_by_id(item)
      end
    top_items
    end
  end






end
