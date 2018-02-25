module CustomerAnalytics
  def top_buyers(num = 20)
    hash = {}
    customers.each do |customer|
      invoices = get_invoices(customer.id)
      paid_invoices = invoices.find_all(&:is_paid_in_full?)
      invoice_costs = paid_invoices.map(&:total)
      hash[invoice_costs.reduce(:+).to_f] = customer
    end
    top_customers = hash.keys.max(num)
    top_customers.map { |key| hash[key] }
  end

  def get_invoices(customer_id)
    @sales_engine.invoices.find_all_by_customer_id(customer_id)
  end

  def one_time_buyers
    buyers = []
    customers.map do |customer|
      invoices = get_invoices(customer.id)
      paid_invoices = invoices.find_all(&:is_paid_in_full?)
      paid_invoices.delete(false)
      buyers << customer if paid_invoices.length == 1
    end
    buyers
  end

  def one_time_buyers_top_items
    customers = one_time_buyers
    hash = Hash.new(0)
    customers.each do |customer|
      invoices = customer.fully_paid_invoices
      invoices.each do |invoice|
        invoice_items = @sales_engine.invoice_items.find_all_by_invoice_id(invoice.id)
        invoice_items.each do |invoice_item|
          hash[@sales_engine.items.find_by_id(invoice_item.item_id)] += invoice_item.quantity
        end
      end
    end
    [hash.key(hash.values.sort.last)]
  end

  def finding_invoice_items(id)
  new_stuff = Hash.new
  customer = @sales_engine.customers.find_by_id(id)
  customer.invoices.map do |invoice|
    new_stuff[invoice] = invoice.quantity
    end
  new_stuff
  end

  def top_merchant_for_customer(id)
    high = finding_invoice_items(id).max_by do|invoice, orders|
      orders
    end
    high[0].merchant
  end

  def finding_invoice_bought_in_a_year(id, year)
    customer = @sales_engine.customers.find_by_id(id)
    invoices = customer.invoices.find_all do |invoice|
        invoice.created_at.to_s[0..3].to_i == year
      end
    invoices
    end

  def items_bought_in_year(id, year)
    invoices = finding_invoice_bought_in_a_year(id, year)
    invoices.map do |invoice|
      invoice.items.map do |item|
        item
      end
    end.flatten
  end

  def highest_volume_items(customer_id)
    customer = @sales_engine.customers.find_by_id(customer_id)
    invoices = customer.invoices
    invoice_items = invoices.map do |invoice|
      @sales_engine.invoice_items.find_all_by_invoice_id(invoice.id)
    end.flatten
    quantities = invoice_items.map(&:quantity)
    array = []
    quantities.each_with_index do |num, index|
      if num == quantities.max
        array << @sales_engine.items.find_by_id(invoice_items[index].item_id)
      end
    end
    array
  end

  def customers_with_unpaid_invoices
    unpaid = []
      customers.map do |customer|
        customer.invoices
      end.flatten.each do |invoice|
        if invoice.is_paid_in_full? == false
          unpaid << invoice.customer
        end
      end
  unpaid.uniq
  end

  def sorting_invoices_by_quantity
    quantity_hash = {}
    invoices.each do |invoice|
      quantity_hash[invoice] = invoice.quantity if invoice.is_paid_in_full?
    end
    quantity_hash
  end

  def best_invoice_by_quantity
    high_quantity = sorting_invoices_by_quantity.max_by do |invoice, quantity|
      quantity
    end
    high_quantity[0]
  end

  def sorting_invoices_by_revenue
    revenue_hash = Hash.new
    invoices.each do |invoice|
      if invoice.is_paid_in_full?
        revenue_hash[invoice] = invoice.total
      end
    end
    revenue_hash
  end

  def best_invoice_by_revenue
    high_revenue = sorting_invoices_by_revenue.max_by do |invoice, revenue|
      revenue
    end
    high_revenue[0]
  end
end 
