## Iteration 4 Method Description

### most_sold_item_for_merchant(merchant_id)
- Pass `merchant_id` into method, and return all of merchant's invoices (`invoices`).
- Check that invoices had successful transactions; only return the invoices where true (`validated_invoices`).
- Iterate over `validated_invoices` to return `invoice_items`, quantity, etc **(Need refining here)**
- Iterate over `invoice_items` and find associated `items`; use hash data structure so quantity sold of each `invoice_item` is passed.
- Iterate over `items` and sort by most sold.

## best_item_for_merchant(merchant_id)

