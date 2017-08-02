module CustomerAnalytics

  private

    def get_invoice_items_from_array(arr)
      arr.reduce([]) do |invoice_items, element|
        invoice_items << element.invoice_items
        invoice_items.flatten
      end
    end

    def get_items_from_array(arr)
      arr.reduce([]) do |items, element|
        items << element.items
      end
    end

    def total_quantity_of_item_in_invoice_item_array(item, invoice_item_array)
      item_invoice_items = invoice_item_array.find_all do |invoice_item|
        invoice_item.item_id == item.id
      end
      item_invoice_items.reduce(0) {|total, invoice_item| total += invoice_item.quantity}
    end

    def find_paid_customer_invoices(customer_id)
      customer_invoices = @invoices.find_all_by_customer_id(customer_id)
      customer_invoices.find_all do |invoice|
        invoice.is_paid_in_full?
      end
    end

    def find_top_items_by_quantity(item_array, invoice_item_array)
      item_array.find_all do |item|
        max = total_quantity_of_item_in_invoice_item_array(item_array[0], invoice_item_array)
        current = total_quantity_of_item_in_invoice_item_array(item, invoice_item_array)
        current == max
      end
    end

  public

    def top_buyers(num=20)
      @customers.customers_by_expenditure[0..(num -1)]
    end

    def top_merchant_for_customer(customer_id)
      @customers.customer_merchants_by_customer_expenditure(customer_id)[0]
    end

    def one_time_buyers
      @customers.all.find_all do |customer|
        customer_invoices = @customers.customer_repo_to_se_invoices(customer.id)
        customer_invoices.length == 1 && customer_invoices[0].transactions.length == 1
      end
    end

    def one_time_buyers_item
      buyers = one_time_buyers
      total_items = get_invoice_items_from_array(buyers)
      buyer_item = total_items.max_by {|item| total_items.count(item)}
      buyer_item.items
    end

    def items_bought_in_year(customer_id, year)
      customer_invoices = find_paid_customer_invoices(customer_id)
      invoices_in_year = customer_invoices.find_all {|invoice| invoice.created_at.year == year}
      invoice_items_in_year = get_invoice_items_from_array(invoices_in_year)
      get_items_from_array(invoice_items_in_year)
    end

    def highest_volume_items(customer_id)
      customer_invoices = find_paid_customer_invoices(customer_id)
      customer_invoice_items = get_invoice_items_from_array(customer_invoices)
      customer_items = get_items_from_array(customer_invoice_items).uniq
      customer_items = customer_items.sort_by do |item|
        total_quantity_of_item_in_invoice_item_array(item, customer_invoice_items)
      end
      find_top_items_by_quantity(customer_items.reverse, customer_invoice_items)
    end

    def customers_with_unpaid_invoices
      @customers.all.find_all do |customer|
        customer.invoices.any? {|invoice| !(invoice.is_paid_in_full?)}
      end
    end

end
