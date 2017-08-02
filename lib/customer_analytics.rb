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
      customer_invoices.length == 1 && customer_invoices[0].transactions.length == 1
    end
  end

  def one_time_buyers_item
    buyers = one_time_buyers
    total_items = buyers.reduce([]) do |invoice_items, customer|
      invoice_items << customer.invoice_items
      invoice_items.flatten
    end
    buyer_item = total_items.max_by {|item| total_items.count(item)}
    buyer_item.item
  end

end
