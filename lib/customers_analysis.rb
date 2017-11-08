module CustomersAnalysis
  def top_buyers(number_of_buyers = 20)
    customers_with_total = Hash.new(0)

    se.invoices.all.each do |invoice|
      customers_with_total[invoice.customer] += invoice.total
    end

    sorted_customers = customers_with_total.sort_by do |customer, total|
      total
    end.reverse

    top_spenders = sorted_customers.take(number_of_buyers)

    top_spenders.map do |customer|
      customer[0]
    end
  end

  def top_merchant_for_customer(customer_id)
    all_invoices = se.invoices.find_all_by_customer_id(customer_id)

    hash = Hash.new(0)

    all_invoices.each do |invoice|
      hash[invoice.merchant] = quantity(invoice.invoice_items)
    end

    hash.max_by{|merchant, item_count| item_count}.first
  end

  def quantity(invoice_items)
    invoice_items.map do |invoice_item|
      invoice_item.quantity
    end.sum
  end

  def one_time_buyers
    specific_customers = se.customers.all.reduce({}) do |result, customer|
      result[customer] = customer.fully_paid_invoices.count
      result
    end

    one_time_customers = specific_customers.find_all do |cust, paid_invoices|
      paid_invoices == 1
    end

    one_time_customers.map do |customer, paid_invoices|
      customer
    end
  end

  def one_time_buyers_top_items
    all_invoices = one_time_buyers.map do |customer|
      customer.fully_paid_invoices
    end.flatten

    all_invoice_items = all_invoices.map do |invoice|
      invoice.invoice_items
    end.flatten

    items_with_quantity = Hash.new(0)

    all_invoice_items.each do |invoice_item|
      if items_with_quantity[invoice_item.item_id]
        items_with_quantity[invoice_item.item_id] += invoice_item.quantity
      else
        items_with_quantity[invoice_item.item_id] = invoice_item.quantity
      end
    end

    top_item_ID = items_with_quantity.max_by do |item, quantity|
      quantity
    end

    Array.new << se.items.find_by_id(top_item_ID[0])
  end

  def highest_volume_items(customer_ID)
    #First step --> find that customer
    customer = se.customers.find_by_id(customer_ID)
    #Find all fully paid invoices from that customer
    all_invoices = customer.find_invoices_linked_to_customer
    #Now find all InvoiceItems for these invoices
    all_invoice_items = all_invoices.map do |invoice|
      invoice.invoice_items
    end.flatten
    #Now generate hash with itemIDs => invoice_item.quantity
    items_with_quantity = Hash.new(0)

    all_invoice_items.each do |invoice_item|
      if items_with_quantity[invoice_item.item_id]
        items_with_quantity[invoice_item.item_id] += invoice_item.quantity
      else
        items_with_quantity[invoice_item.item_id] = invoice_item.quantity
      end
    end
    #Now find the item with the max cumulative quantity
    max_item_quantity = items_with_quantity.values.max

    max_items = items_with_quantity.find_all do |item, quantity|
      quantity == max_item_quantity
    end

    max_items.map do |item_and_quantity|
      se.items.find_by_id(item_and_quantity[0])
    end
  end

  def customers_with_unpaid_invoices
    se.customers.all.find_all do |customer|
      customer.find_invoices_linked_to_customer.any? do |invoice|
        invoice.is_paid_in_full? == false
      end
    end
  end

  def items_bought_in_year(customer_id, year)
    #first find customer by customer ID
    customer = se.customers.find_by_id(customer_id)
    #find all of those customer's invoices
    invoices = customer.find_invoices_linked_to_customer
    #filter out for invoices from that year
    invoices_from_year = invoices.find_all do |invoice|
      invoice.created_at.year == year
      # binding.pry
    end
    #now find all items from these invoices
    invoices_from_year.map do |invoice|
      invoice.items
    end.flatten

  end

end
