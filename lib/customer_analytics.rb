module CustomerAnalytics
  def group_invoices_by_customer_id
    @parent.invoices.all.group_by { |invoice| invoice.customer_id }
  end

  def customer_id_invoice_totals
    new_hash = {}
    group_invoices_by_customer_id.each do |cust_id, invoices|
      new_hash[cust_id] = invoices.inject(0) do |sum, invoice|
        sum + invoice_total(invoice.id)
      end
    end
    new_hash
  end

  def invoice_totals_for_customer_id(customer_id)
    invoices = @parent.invoices.find_all_by_customer_id(customer_id)
    invoices.map { |invoice| invoice_total(invoice.id) }
  end

  def merchant_ids_for_customer(customer_id)
    invoices = @parent.invoices.find_all_by_customer_id(customer_id)
    invoices.map { |invoice| invoice.merchant_id }
  end

  def merchant_totals_per_customer(invoice_totals, merchant_ids)
    merch_totals = {}
    merchant_ids.each_with_index do |id, index|
      merch_totals[id] = invoice_totals[index] if merch_totals[id].nil?
      merch_totals[id] += invoice_totals[index] unless merch_totals[id].nil?
    end
    merch_totals
  end

  def all_merchant_ids_with_invoices
    invoices = @parent.invoices.all
    invoices.map { |invoice| invoice.merchant_id }
  end

  def all_customer_ids_with_invoices
    invoices = @parent.invoices.all
    invoices.map { |invoice| invoice.customer_id }
  end

  def one_time_customer_ids
    merchant_ids = all_customer_ids_with_invoices
    customer_ids = all_customer_ids_with_invoices
    merchs_per_cust = merchant_ids_per_customer_id(merchant_ids, customer_ids)
    cust = merchs_per_cust.find_all { |_cust_id, merch_ids| merch_ids.length == 1 }
    cust.map { |cust_per_merch| cust_per_merch[0] }
  end

  def merchant_ids_per_customer_id(merchant_ids, customer_ids)
    customers_per_merch = {}
    customer_ids.each_with_index do |cust_id, index|
      if customers_per_merch[cust_id].nil?
        customers_per_merch[cust_id] = [merchant_ids[index]]
      else
        customers_per_merch[cust_id].push(merchant_ids[index])
      end
    end
    customers_per_merch
  end

  def quantity_per_item_id(invoice_items)
    invoice_items.inject(Hash.new(0)) do |hash, invoice_item|
      hash[invoice_item.item_id] += invoice_item.quantity
      hash
    end
  end

  def delete_unpaid(invoices)
    invoices.delete_if { |invoice| !invoice_paid_in_full?(invoice.id) }
  end

  def one_time_invoices
    one_time_customer_ids.map do |cust_id|
      @parent.invoices.find_all_by_customer_id(cust_id)
    end.flatten
  end

  def max_quantity_invoice_item_id(invoice_items)
    quantity_per_item_id(invoice_items).max_by { |_itm_id, quantity| quantity }[0]
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

  def invoice_items_from_customer_id(customer_id)
    invoices = @parent.invoices.find_all_by_customer_id(customer_id)
    invoice_items_for_invoices(invoices)
  end

  def invoice_items_for_invoices(invoices)
    invoices.map do |invoice|
      @parent.invoice_items.find_all_by_invoice_id(invoice.id)
    end.flatten
  end

  def quantity_per_invoice_item(invoice_items)
    invoice_items.inject(Hash.new(0)) do |hash, item|
      hash[item.item_id] += item.quantity
      hash
    end
  end

  def find_items_with_highest_quantity(highest_quantity, quantity_per_item)
    item_ids = quantity_per_item.find_all do |item, quantity|
      item if quantity == highest_quantity
    end
    item_ids.map { |item_id| @parent.items.find_by_id(item_id[0]) }
  end

  def invoice_ids_and_totals(invoice_items)
    invoice_items.inject(Hash.new(0)) do |hash, invoice_item|
      hash[invoice_item.invoice_id] += (invoice_item.quantity *
        invoice_item.unit_price)
      hash
    end
  end

  def invoice_ids_and_quantities(invoice_items)
    invoice_items.inject(Hash.new(0)) do |hash, invoice_item|
      hash[invoice_item.invoice_id] += invoice_item.quantity
      hash
    end
  end
end
