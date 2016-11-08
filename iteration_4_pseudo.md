# Method #1:
```rb
sa.total_revenue_by_date(date) #=> $$
```

* Lives in SalesAnalyst
* Iterate through invoice_repo.all to find_all created_at (date)
* Return the unit_price of each invoice_item it finds
* Format to spec
  * We may have to sharpen this to only include completed transactions
  per Transaction, since it's asking for revenue, but we have
  to us the unit_price from invoice_item (IIRepo.find_all_by_result)


# Method #2:
```rb
sa.top_revenue_earners(5) #=> [merchant, merchant, merchant, merchant, merchant]
```

  * Main method lives in SalesAnalyst
  * Argument represents top X performers, default value is 20
  * Iterate through each merchant.invoices to find_all invoices corresponding to its completed transactions
    * Maybe status :shipped would work instead? If not we'll have to communicate with transactions
  * Iterate through each invoice_item on each returned invoice and return the unit_price sum (reduce)
  * Store as hash, where key is merchant.name and value is total revenue determined in last step
  * Sort the hash like this: 
        
        ranked = hash.sort_by { |key/name, value/revenue| value/revenue }
        ranked_hash = Hash.new
        ranked.each do |pair|
          ranked_hash[pair[0]] = pair[1]
        end
        => => ranked_hash.keys[0...argument]

  **A later method asks us to find the total revenue for a given merchant, so building that hash will
    get two birds stoned at once**


# Method #3:
```rb
sa.merchants_with_pending_invoices #=> [merchant, merchant, merchant]
```

* Lives in SalesAnalyst
* If invoice.status(:pending) doesn't get us expected results, refer to tip from spec:
  **Note: an invoice is considered pending if none of its transactions are successful.**




