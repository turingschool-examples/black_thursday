module MarketAnalytics

  private

    def enumerate_item_invoices(item, attribute_proc)
      item_invoices = @invoice_items.find_all_by_item_id(item.id)
      if !(item_invoices.empty?)
        value = item_invoices.reduce(0) do |passed_value, invoice_item|
          passed_value += attribut_proc.call(invoice_item)
        end
      else
        return 0
      end
    end

  public

    def total_revenue_by_date(date)
      relevant_items = @transactions.id_repo.values.reduce([]) do |result, transaction|
        if transaction.created_at == date
          if transaction.result == :success
            invoice = transaction.invoice
            result << invoice.items
          end
        end
        result.flatten
      end
      relevant_items.reduce(0) do |total, item|
        total += (item.unit_price * item.quantity)
        total
      end
    end

    def revenue_by_merchant(merchant_id)
      merchant = @merchants.find_by_id(merchant_id)
      return merchant.invoices.reduce(0) do |total, invoice|
        merchant_invoice_items = @invoice_items.find_all_by_invoice_id(invoice.id)
        total += merchant_invoice_items.reduce(0) do |item_total, item|
          item_total += item.quantity * item.unit_price
          item_total
        end
        total
      end
    end

    def top_revenue_earners(number=20)
      top_earners = []
      number.times do
        top_earner = ""
        @merchants.id_repo.keys.reduce(0) do |max_revenue, id|
          revenue = revenue_by_merchant(id)
          if revenue >= max_revenue && !(top_earners.include?(@merchants.id_repo[id]))
            max_revenue = revenue
            top_earner = @merchants.id_repo[id]
          end
        end
        top_earners << top_earner
      end
      top_earners.compact
    end

    def most_sold_item_for_merchant(merchant_id)
      merchant = @merchants.find_by_id(merchant_id)
      max_count = 0
      high_item = merchant.items.reduce([]) do |high_item, item|
        count = enumerate_item_invoices(item, Proc.new {|invoice_item| invoice_item.quantity})
        if count > max_count
          max_count = count
          high_item = [item]
        elsif count == max_count
          high_item << item
        end
      end
      high_item
    end

    def best_item_for_merchant(merchant_id)
      merchant = @merchants.find_by_id(merchant_id)
      max_revenue = 0
      high_item = merchant.items.reduce([]) do |high_item, item|
        revenue = enumerate_item_invoices(item, Proc.new {|invoice_item| invoice_item.quantity * invoice_item.unit_price})
        if revenue >= max_revenue
          max_revenue = revenue
          high_item = item
        end
      end
      high_item
    end
end
