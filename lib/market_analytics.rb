module MarketAnalytics

  private

    def merchant_paid_invoice_items(merchant_id)
      merchant = @merchants.find_by_id(merchant_id)
      paid_invoices = merchant.invoices.find_all {|invoice| invoice.is_paid_in_full?}
      paid_invoice_items =  paid_invoices.reduce([]) do |total_item_instances, invoice|
        total_item_instances << @invoice_items.id_repo.values.find_all do |item|
          invoice.id == item.invoice_id
        end
        total_item_instances.flatten
      end
    end

    def create_invoice_item_hash_by_attribute(invoice_item_array, attribute_proc)
      invoice_item_array.reduce({}) do |q_hash, invoice_item|
        if !(q_hash.keys.include?(invoice_item.item_id))
          q_hash.store(invoice_item.item_id, attribute_proc.call(invoice_item))
        else
          q_hash[invoice_item.item_id] += attribute_proc.call(invoice_item)
        end
      end
    end

    def invoices_on_this_date(date)
      @invoices.id_repo.values.reduce([]) do |on_this_date, invoice|
        if invoice.is_paid_in_full?
          on_this_date << invoice
        end
        on_this_date
      end
    end

  public

    def total_revenue_by_date(date)
      invoices_on_this_date(date).reduce(0) do |total_revenue, invoice|
        total_revenue += invoice.total
      end
    end

    def revenue_by_merchant(merchant_id)
      merchant = @merchants.find_by_id(merchant_id)
      return merchant.invoices.reduce(0) do |total, invoice|
        total += invoice.total
      end
    end

    def top_revenue_earners(number=20)
      duplicated_merchant_repo = merchants.id_repo.clone
      top = []
      number.times do
        max = duplicated_merchant_repo.max_by {|merchant| revenue_by_merchant(merchant[0])}
        duplicated_merchant_repo.delete(max[0])
        top << @merchants.id_repo.find_by_id(max[0])
      end
      top
    end

    def most_sold_item_for_merchant(merchant_id)
      paid_invoice_items = merchant_paid_invoice_items(merchant_id)
      quantity_proc = Proc.new {|invoice_item| invoice_item.quantity}
      quantity_hash = create_invoice_item_hash_by_attribute(paid_invoice_items, quantity_proc)
      most_sold_item_id = quantity_hash.max_by {|pair| pair[1]}
      @items.find_by_id(most_sold_item_id)
    end

    def best_item_for_merchant(merchant_id)
      paid_invoice_items = merchant_paid_invoice_items(merchant_id)
      quantity_proc = Proc.new {|invoice_item| invoice_item.quantity * invoice_item.unit_price.to_f}
      quantity_hash = create_invoice_item_hash_by_attribute(paid_invoice_items, quantity_proc)
      most_sold_item_id = quantity_hash.max_by {|pair| pair[1]}
      @items.find_by_id(most_sold_item_id)
    end

end
