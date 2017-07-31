module CustomerAnalytics

  def top_buyers(num=20)
    buyers = []
    num.times do
      max_revenue = 0
      top_buyer = @customer.id_repo.values.reduce("") do |top_customer, customer|
        revenue = customer.invoices.reduce(0) do |money, invoice|
          if invoice.is_paid_in_full?
            money += @invoices_items.id_repo.values.reduce(0) do |moneyy, invoice_item|
              if invoice_item.invoice_id == invoice.id
                moneyy += invoice_item.unit_price
              end
            end
          end
        end
        if revenue >= max_revenue && !(buyers.include?(customer))
          max_revenue = revenue
          top_customer = customer
        end
      end
      buyers << top_buyer
    end
    buyers.compact
  end


end
