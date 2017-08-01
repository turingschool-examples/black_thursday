module CustomerAnalytics

  def

  def top_buyers(num=20)
    tup_buyers = []
    num.times do
      @customers.all.find_all do |customer|

        revenue = customer.invoices.reduce(0) do |revenue, invoice|
          if invoice.is_paid_in_full?
            revenue += invoice.total
          end
          revenue
        end

      end
    end

end
