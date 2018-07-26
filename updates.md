bundle exec rspec spec/iteration_2_spec.rb
Finished:
*sales_analyst = sales_engine.analyst

Work in Progress/Updates:
*sales_analyst.average_items_per_merchant # => 2.88

Pending:
Iteration 1
*sales_analyst.average_items_per_merchant_standard_deviation # => 3.26
*sales_analyst.merchants_with_high_item_count # => [merchant, merchant, merchant]
*sales_analyst.average_item_price_for_merchant(12334159) # => BigDecimal
*sales_analyst.average_average_price_per_merchant # => BigDecimal
*sales_analyst.golden_items # => [<item>, <item>, <item>, <item>]

Iteraltion 2
*sales_analyst = sales_engine.analyst
*sales_analyst.average_invoices_per_merchant # => 10.49
*sales_analyst.average_invoices_per_merchant_standard_deviation # => 3.29
*sales_analyst.top_merchants_by_invoice_count # => [merchant, merchant, merchant]
*sales_analyst.bottom_merchants_by_invoice_count # => [merchant, merchant, merchant]
*sales_analyst.top_days_by_invoice_count # => ["Sunday", "Saturday"]
*sales_analyst.invoice_status(:pending) # => 29.55
sales_analyst.invoice_status(:shipped) # => 56.95
sales_analyst.invoice_status(:returned) # => 13.5

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
