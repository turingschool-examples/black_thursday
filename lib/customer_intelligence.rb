module CustomerIntelligence
  def one_time_buyers
    @customers.all.find_all do |customer|
      invoices.all.one?{|invoice| invoice.customer_id == customer.id}
    end
  end

  def top_buyers(n = 20)
    customers.all.sort_by do |customer|
      0 - (revenue_from_invoices(find_invoices_from(customer)))
    end.slice(0, n)
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

  def invoices_grouped_by_customer_id
    invoices.all.group_by {|invoice| invoice.customer_id}
  end

  def top_merchant_for_customer(customer_id)
    top_invoice = nil
    customer = customers.find_by_id(customer_id)
    find_invoices_from(customer).reduce(0) do |top_item_count, invoice|
      next top_item_count unless at_least_one_succesful_transaction?(invoice.id)
      if get_item_count_for(invoice) > top_item_count
        top_invoice = invoice
        top_item_count = invoice_item_count
      end
      top_item_count
    end
    merchants.find_by_id(top_invoice.merchant_id)
  end

  def find_invoice_with_most_items_from(customer)
    find_invoices_from(customer, 'Customer').reduce()
  end

  def highest_volume_items(customer_id)
    all_invoices = invoices.find_all_by_customer_id(customer_id)
    top_quantity = find_highest_quantity_for(all_invoices)
    all_invoices.reduce([]) do |top_i, invoice|
      invoice_items = get_top_invoice_items_for(invoice)
      invoice_items.each do |invoice_item|
        if invoice_item.quantity == top_quantity
          top_i << items.find_by_id(invoice_item.item_id)
        end
      end
      top_i
    end
  end

  def customers_with_unpaid_invoices
    find_from_invoices(unsuccessful_invoices, "Customer").uniq
  end

  def items_bought_in_year(customer_id, year)
    invoices_in_year = @invoices.find_all_by_customer_id(customer_id).select { |invoice| invoice.created_at.year == year}
    item_ids = invoices_in_year.map do |invoice|
      @invoice_items.find_all_by_invoice_id(invoice.id).map { |invoice_item| invoice_item.item_id}
    end.flatten.uniq.compact
    item_ids.map { |item_id| @items.find_by_id(item_id) }
  end
end
