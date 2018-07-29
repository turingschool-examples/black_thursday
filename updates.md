bundle exec rspec spec/iteration_2_spec.rb
Completed Iterations: 0, 1, 2

Iteration 4
Finished:

Work in Progress/Updates:

Pending:

Iteration 4: Merchant Analytics
*sales_analyst = sales_engine.analyst
*sales_analyst.total_revenue_by_date(date) #=> $$
*sales_analyst.top_revenue_earners(x) #=> [merchant, merchant, merchant, merchant, merchant]
*sales_analyst.top_revenue_earners #=> [merchant * 20]
*sales_analyst.merchants_with_pending_invoices #=> [merchant, merchant, merchant]
*sales_analyst.merchants_with_only_one_item #=> [merchant, merchant, merchant]
*sales_analyst.merchants_with_only_one_item_registered_in_month("Month name") #=> [merchant, merchant, merchant]
*sales_analyst.revenue_by_merchant(merchant_id) #=> $
*sales_analyst.most_sold_item_for_merchant(merchant_id) #=> [item] (in terms of quantity sold) or, if there is a tie, [item, item, item]
*sales_analyst.best_item_for_merchant(merchant_id) #=> item (in terms of revenue generated)

Iteration 3
*sales_analyst.invoice_paid_in_full?(invoice_id) returns true if the Invoice with the corresponding id is paid in full
*sales_analyst.invoice_total(invoice_id) returns the total $ amount of the Invoice with the corresponding id.
Notes:
Failed charges should never be counted in revenue totals or statistics.
An invoice is considered paid in full if it has a successful transaction
