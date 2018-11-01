module CustomerIntelligence
  def top_buyers(n = 20)
    customers.all.sort_by do |customer|
      0 - (revenue_from_invoices(find_invoices_from(customer)))
    end.slice(0, n)
  end

  def one_time_buyers
    customers.all.find_all do |customer|
      invoices.all.one?{|invoice| invoice.customer_id == customer.id}
    end
  end

  def one_time_buyers_top_item
    top_transaction_count = find_highest_transaction_count_from(one_time_buyers)

    top_inv_items = one_time_buyers.reduce([]) do |top, one_timer|
      invoice = find_invoices_from(one_timer)[0]
      top_item = get_top_invoice_items_for(invoice, false)
      current = get_transaction_count_for(top_item)
      top << top_item if current >= top_transaction_count
      top
    end

    items.find_by_id(top_inv_items.first.item_id)
  end

  def top_merchant_for_customer(customer_id)
    customer = customers.find_by_id(customer_id)
    top_invoice = find_invoice_with_most_items_from(customer)
    merchants.find_by_id(top_invoice.merchant_id)
  end

  def find_invoice_with_most_items_from(customer)
    top_invoice = nil
    find_invoices_from(customer).reduce(0) do |top_item_count, invoice|
      next top_item_count unless at_least_one_succesful_transaction?(invoice.id)
      current_count = get_item_count_for(invoice)
      if current_count > top_item_count
        top_invoice = invoice
        top_item_count = current_count
      end
      top_item_count
    end
    top_invoice
  end

  def highest_volume_items(customer_id)
    customer = customers.find_by_id(customer_id)
    top_quantity = find_highest_quantity_invoice_item_from(customer)

    find_invoices_from(customer).reduce([]) do |top_i, invoice|
      get_top_invoice_items_for(invoice).each do |invoice_item|
        current = invoice_item.quantity
        top_i << items.find_by_id(invoice_item.item_id) if current == top_quantity
      end
      top_i
    end
  end

  def customers_with_unpaid_invoices
    find_from_invoices(unsuccessful_invoices, "Customer").uniq
  end

  def items_bought_in_year(customer_id, year)
    all_invoices_for_customer_for_year(customer_id, year).map do |invoice|
      find_from_invoice(invoice, 'InvoiceItem').map do |invoice_item|
        items.find_by_id(invoice_item.item_id)
      end
    end.flatten.compact.uniq
  end

  def all_invoices_for_customer_for_year(customer_id, year)
    invoices.find_all_by_customer_id(customer_id).select do |invoice|
      invoice.created_at.year == year
    end
  end
end
