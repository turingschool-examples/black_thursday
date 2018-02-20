---
layout: page
title: Black Thursday Iteration 5
---
Iteration 5: Customer Analytics
==================

Our marketing team is asking for better data about of our customer base to launch a new project and have the following requirements:

Find out whether or not a given invoice is paid in full:   

```rb
# invoice.transactions.map(&:result) #=> ["failed", "success"]  
invoice.is_paid_in_full? #=> true

# invoice.transactions.map(&:result) #=> ["failed", "failed"]  
invoice.is_paid_in_full? #=> false
```

**Note:** Returns true if at least one of the associated transactions' result is "success".  

Find the x customers that spent the most $:

```rb
sa = SalesAnalyst.new

sa.top_buyers(x) #=> [customer, customer, customer, customer, customer]
```

If no number is given for `top_buyers`, it takes the top 20 customers by default

```rb
sa = SalesAnalyst.new

sa.top_buyers #=> [customer * 20]
```

Be able to find which merchant the customers bought the most items from:

```rb
sa = SalesAnalyst.new

sa.top_merchant_for_customer(customer_id) #=> merchant
```

Find which customers only had one transaction:

```rb
sa = SalesAnalyst.new

sa.one_time_buyers #=> [customer, customer, customer]
```

Find which item most `one_time_buyers` bought:

```rb
sa = SalesAnalyst.new

sa.one_time_buyers_item #=> [item]
```

Find which items a given customer bought in given year (by the `created_at` on the related invoice):

```rb
sa = SalesAnalyst.new

sa.items_bought_in_year(customer_id, year) #=> [item]
```

Return item(s) that customer bought in largest cumulative quantity. If there are several items with the same highest quantity, return all items:

```rb
sa = SalesAnalyst.new

sa.highest_volume_items(customer_id) #=> [item] or [item, item, item]
```

Find customers with unpaid invoices:

```rb
sa = SalesAnalyst.new

sa.customers_with_unpaid_invoices #=> [customer, customer, customer]
```

**Note:** invoices are unpaid if one or more of the invoices are not paid in full (see method `invoice#is_paid_in_full?`).

Find the best invoice, the invoice with the highest dollar amount:

```rb
sa.best_invoice_by_revenue #=> invoice
```

```rb
sa.best_invoice_by_quantity #=> invoice
```
