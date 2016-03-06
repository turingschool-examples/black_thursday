SalesAnalyst class
- move averages to respective classes? then call in SA to calc std-dev?

Inventory: Average calcs
- average_items_per_merchant => calls on items repository / STAY
- items_per_merchant_hash => calls on items repository / MOVED TO MERCHANT REPOSITORY
- item_count_per_merchant_hash => calls on items_per_merchant_hash / MOVED TO MERCHANT REPOSITORY
- average_items_per_merchant_standard_deviation => takes in item_count_per_merchant_hash, average_items_per_merchant, merchants repository / BROKE INTO SQUARED DIFFERENCE, SAMPLE, VARIANCE METHODS
- one_std_dev_for_average_items_per_merchant => average_items_per_merchant_standard_deviation, average_items_per_merchant
- merchants_with_high_item_count => one_std_dev_for_average_items_per_merchant, item_count_per_merchant_hash

- average_item_price_for_merchant => items_per_merchant_hash
- average_average_price_per_merchant => items_per_merchant_hash

- average_item_price_for_merchant_hash => items_per_merchant_hash, average_item_price_for_merchant(merchant_id)

- average_price_of_all_items  => items repository
- average_item_price_standard_deviation => items repository
- two_std_dev_for_average_item_price => average_item_price_standard_deviation, average_price_of_all_items
- golden_items => two_std_dev_for_average_item_price, items repository

- average_invoices_per_merchant => invoices repository REFACTOR, looked at method invoice_count_per_merchant_hash
- invoices_per_merchant_hash => invoices repository
- invoice_count_per_merchant_hash => merchants repository
- average_invoices_per_merchant_standard_deviation => invoice_count_per_merchant_hash, average_invoices_per_merchant, merchants repository
- two_std_dev_average_invoice_count => average_invoices_per_merchant_standard_deviation
- two_std_dev_above_average_invoice_count => average_invoices_per_merchant, two_std_dev_average_invoice_count
- two_std_dev_below_average_invoice_count => average_invoices_per_merchant, two_std_dev_average_invoice_count
- top_merchants_by_invoice_count => two_std_dev_above_average_invoice_count, merchants repository, merchants
- bottom_merchants_by_invoice_count => two_std_dev_below_average_invoice_count, merchants repository, merchants

- average_invoices_per_day => invoices repository
- invoices_for_day_hash => invoices repository
- count_of_invoices_for_day_hash => invoices_for_day_hash
- average_invoices_per_day_standard_deviation => count_of_invoices_for_day_hash, average_invoices_per_day
- one_std_dev_above_average_invoice_count => average_invoices_per_day_standard_deviation, average_invoices_per_day
- top_days_by_invoice_count => one_std_dev_above_average_invoice_count, count_of_invoices_for_day_hash
- invoice_status => invoice repository


make-up of standard deviation:
3 inputs: hash for elements, average of elements, number of sample

--> hash for elements
