module CustomerAnalyst
  def top_buyers(x = 20)
    customer_spend = customer_spend(all_customer_invoices)
    sorted = sorted_customer_spend(customer_spend)
    sorted.take(x).map do |(customer_id, spend)|
      se.find_customer_by_id(customer_id)
    end
  end

  def top_merchant_for_customer(customer_id)
    customer_invoices = se.invoices.find_all_by_customer_id(customer_id)
    merchant_totals = customer_total_spend_per_merchant(customer_invoices)
    merchant = merchant_totals.max_by {|(merchant, total_spend)| total_spend}[0]
    se.merchants.find_by_id(merchant)
  end

  def one_time_buyers
    se.customers.all.reduce([]) do |result, customer|
      result << customer if customer.fully_paid_invoices.count == 1
      result
    end
  end

  def one_time_buyers_top_items
    item_count = accumulate_invoice_items(one_time_buyers_invoice_items)
    top_item = item_count.max_by {|(item, count)| count}[0]
    [se.items.find_by_id(top_item)]
  end

  def items_bought_in_year(customer_id, year)
    invoices_for_year(customer_id, year).map do |invoice|
      se.find_items_by_invoice_id(invoice.id)
    end.flatten
  end

  def highest_volume_items(customer_id)
    customer = se.customers.find_by_id(customer_id)
    invoice_items = customer.invoices.map {|invoice| invoice.invoice_items}
    counted_invoice_items = accumulate_invoice_items(invoice_items.flatten)
    maximum_occuring_items(counted_invoice_items).map do |(item_id, count)|
      se.items.find_by_id(item_id)
    end
  end

  def customers_with_unpaid_invoices
    se.customers.all.reduce([]) do |result, customer|
      result << customer if customer.invoices != customer.fully_paid_invoices
      result
    end
  end

  def best_invoice_by_revenue
    se.invoices.all.max_by do |invoice|
      invoice.total
    end
  end

  def best_invoice_by_quantity
    paid_invoices = se.invoices.all.reduce([]) do |result, invoice|
      result << invoice if invoice.is_paid_in_full?
      result
    end
    invoice_item_quant = paid_invoices.reduce({}) do |result, invoice|
      quantity = invoice.invoice_items.reduce(0) do |result, invoice_item|
        result += invoice_item.quantity
        result
      end
      result[invoice] = quantity
      result
    end
    invoice_item_quant.max_by do |(invoice, count)|
      count
    end[0]
  end

  private


  def maximum_occuring_items(counted_invoice_items)
    counted_invoice_items.group_by do |(item_id, count)|
      count
    end.max.last
  end

  def accumulate_invoice_items(invoice_items)
    invoice_items.reduce({}) do |result, invoice_item|
      result[invoice_item.item_id] = 0 if !result[invoice_item.item_id]
      result[invoice_item.item_id] += invoice_item.quantity
      result
    end
  end

  def one_time_buyers_invoice_items
    one_time_buyers.map do |customer|
      customer.fully_paid_invoices.first.invoice_items
    end.flatten
  end

  def invoices_for_year(customer_id, year)
    customer_invoices = se.invoices.find_all_by_customer_id(customer_id)
    customer_invoices.find_all do |invoice|
      invoice.created_at.strftime('%Y').to_s == year.to_s
    end
  end

  def customer_total_spend_per_merchant(customer_invoices)
    customer_invoices.reduce({}) do |result, invoice|
      result[invoice.merchant_id] = 0 if !result[invoice.merchant_id]
      result[invoice.merchant_id] += invoice.total
      result
    end
  end

  def all_customer_invoices
    se.invoices.all.reduce({}) do |result, invoice|
      result[invoice.customer_id] = [] if !result.include?(invoice.customer_id)
      result[invoice.customer_id] << invoice.id
      result
    end
  end

  def customer_spend(all_customer_invoices, index = 0, result = {})
    return {} if index == se.customers.all.length
    result = customer_spend(all_customer_invoices, (index + 1), result)
    if !all_customer_invoices[index].nil?
      result[index] = customer_total(all_customer_invoices[index])
    end
    return result
  end

  def customer_total(invoice_ids)
    invoice_ids.map do |invoice_id|
      invoice = se.find_invoice_by_invoice_id(invoice_id)
      invoice.total
    end.sum
  end

  def sorted_customer_spend(customer_spend)
    customer_spend.sort_by do |(customer_id, spend)|
      (-1) * spend
    end
  end
end
