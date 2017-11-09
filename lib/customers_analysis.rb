module CustomersAnalysis
  def top_buyers(number_of_buyers = 20)
    sorted_customers.take(number_of_buyers).map do |customer|
      customer[0]
    end
  end

  def customers_with_total
    customers = Hash.new(0)
    se.invoices.all.each do |invoice|
      customers[invoice.customer] += invoice.total
    end
    customers
  end

  def sorted_customers
    customers_with_total.sort_by do |customer, total|
      total
    end.reverse
  end

  def top_merchant_for_customer(customer_id)
    invoices = se.invoices.find_all_by_customer_id(customer_id)
    merchant_with_item_quantity(invoices).max_by do |merchant, item_count|
      item_count
    end.first
  end

  def merchant_with_item_quantity(invoices)
    invoices.reduce(Hash.new(0)) do |result, invoice|
      result[invoice.merchant] += quantity(invoice.invoice_items)
      result
    end
  end

  def quantity(invoice_items)
    invoice_items.map do |invoice_item|
      invoice_item.quantity
    end.sum
  end

  def one_time_buyers
    one_time_customers.map do |customer, paid_invoices|
      customer
    end
  end

  def specific_customers
    se.customers.all.reduce({}) do |result, customer|
      result[customer] = customer.fully_paid_invoices.count
      result
    end
  end

  def one_time_customers
    specific_customers.find_all do |cust, paid_invoices|
      paid_invoices == 1
    end
  end

  def one_time_buyers_top_items
    items_with_quantity = Hash.new(0)
    one_timer_all_invoice_items.each do |invoice_item|
      if items_with_quantity[invoice_item.item_id]
        items_with_quantity[invoice_item.item_id] += invoice_item.quantity
      else
        items_with_quantity[invoice_item.item_id] = invoice_item.quantity
      end
    end
    [] << se.items.find_by_id(top_item(items_with_quantity)[0])
  end

  def one_time_buyer_invoices
    one_time_buyers.map do |customer|
     customer.fully_paid_invoices
    end.flatten
  end

  def one_timer_all_invoice_items
    one_time_buyer_invoices.map do |invoice|
      invoice.invoice_items
    end.flatten
  end

  def top_item(items_with_quantity)
    items_with_quantity.max_by do |item, quantity|
      quantity
    end
  end

  def customer_invoices(customer_ID)
    current_customer(customer_ID).find_invoices_linked_to_customer
  end

  def current_customer(customer_ID)
    se.customers.find_by_id(customer_ID)
  end

  def current_customer_invoice_items(customer_ID)
    customer_invoices(customer_ID).map do |invoice|
      invoice.invoice_items
    end.flatten
  end

  def highest_volume_items(customer_ID)
    max_items(customer_ID).map do |item_and_quantity|
      se.items.find_by_id(item_and_quantity[0])
    end
  end

  def max_items(customer_ID)
    items_with_quantity(customer_ID).find_all do |item, quantity|
      quantity == max_item_quantity(customer_ID)
    end
  end

  def max_item_quantity(customer_ID)
    items_with_quantity(customer_ID).values.max
  end

  def items_with_quantity(customer_ID)
    result = Hash.new(0)
    current_customer_invoice_items(customer_ID).each do |invoice_item|
      if result[invoice_item.item_id]
        result[invoice_item.item_id] += invoice_item.quantity
      else
        result[invoice_item.item_id] = invoice_item.quantity
      end
    end
    result
  end

  def customers_with_unpaid_invoices
    se.customers.all.find_all do |customer|
      customer.find_invoices_linked_to_customer.any? do |invoice|
        invoice.is_paid_in_full? == false
      end
    end
  end

  def items_bought_in_year(customer_id, year)
    invoices = current_customer(customer_id).find_invoices_linked_to_customer
    invoices_from_year(invoices, year).map do |invoice|
      invoice.items
    end.flatten
  end

  def invoices_from_year(invoices, year)
    invoices.find_all do |invoice|
      invoice.created_at.year == year
    end
  end

end
