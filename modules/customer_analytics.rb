module CustomerAnalytics
  def top_buyers(num_customers = 20)
    customers.max_by(num_customers) do |customer|
      invoice_costs = customer.fully_paid_invoices.map(&:total)
      invoice_costs.inject(:+).to_f
    end
  end

  def get_invoices_for_customer(customer_id)
    invoice_repo.find_all_by_customer_id(customer_id)
  end

  def top_merchant_for_customer(cust_id)
    top = customer_repo.find_by_id(cust_id).all_invoices.max_by do |invoice|
      quantities = invoice.invoice_items.map(&:quantity)
      quantities.inject(:+).to_f
    end.merchant_id
    merchant_repo.find_by_id(top)
  end

  def one_time_buyers
    customers.find_all do |customer|
      paid_invoices = customer.fully_paid_invoices
      paid_invoices.delete(false)
      paid_invoices.length == 1
    end
  end

  def one_time_buyers_top_items
    hash = Hash.new(0)
    one_time_buyers.each do |customer|
      find_fully_paid_invoices(customer, hash)
    end
    [hash.key(hash.values.sort.last)]
  end

  def find_fully_paid_invoices(customer, hash)
    customer.fully_paid_invoices.each do |invoice|
      find_quantities(invoice, hash)
    end
  end

  def find_quantities(invoice, hash)
    invoice.invoice_items.each do |invoice_item|
      hash[item_repo.find_by_id(invoice_item.item_id)] += invoice_item.quantity
    end
  end

  def items_bought_in_year(customer_id, year)
    all_invoices = invoices.find_all do |invoice|
      invoice.customer_id == customer_id && invoice.created_at.year == year
    end.flatten
    all_invoices.map(&:items).flatten.compact
  end

  def highest_volume_items(customer_id)
    customer = customer_repo.find_by_id(customer_id)
    occurances = customer.all_invoice_items.map(&:quantity)
    occurances.map.with_index do |num, index|
      next unless num == occurances.max
      item_repo.find_by_id(customer.all_invoice_items[index].item_id)
    end.compact
  end

  def customers_with_unpaid_invoices
    customers.find_all do |customer|
      customer_invoices = invoice_repo.find_all_by_customer_id(customer.id)
      invoice_status = customer_invoices.map(&:is_paid_in_full?)
      invoice_status.include?(false)
    end
  end

  def best_invoice_by_revenue
    paid_invoices = invoices.find_all(&:is_paid_in_full?)
    paid_invoices.max_by do |invoice|
      invoice.invoice_items.map do |ii|
        ii.unit_price * ii.quantity
      end.reduce(:+).to_f
    end
  end

  def best_invoice_by_quantity
    paid_invoices = invoices.find_all(&:is_paid_in_full?)
    paid_invoices.max_by do |invoice|
      invoice_items = invoice_item_repo.find_all_by_invoice_id(invoice.id)
      quantity = invoice_items.map(&:quantity)
      quantity.reduce(:+).to_f
    end
  end
end
