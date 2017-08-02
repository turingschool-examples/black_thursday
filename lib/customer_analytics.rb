require 'pry'

module CustomerAnalytics

  def top_buyers(num=20)
    @customers.customers_by_expenditure[0..(num -1)]
  end

  def top_merchant_for_customer(customer_id)
    @customers.customer_merchants_by_customer_expenditure(customer_id)[0]
  end

  def one_time_buyers
    @customers.all.find_all do |customer|
      customer_invoices = @customers.customer_repo_to_se_invoices(customer.id)
      customer_invoices == 1 && customer_invoices[0].transactions.length == 1
    end
  end



end
