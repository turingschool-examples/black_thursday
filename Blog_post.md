## Black Thursday Blog Post  

While there are many ways to tackle any problem, this blog posts reflects how our group tackled the sales_analyst.most_sold_item_for_merchant and sales_analyst.best_item_for_merchant methods.  

**sales_analyst.most_sold_item_for_merchant**  

We accomplish this method by first completing the following steps within each merchant object.
1.	*Create the all_invoices_array*  
We reach into the invoice repository to find all of the invoices associated with the merchant.  
2.	*Create the paid_in_full_invoice_array* 
We iterate over the all_invoices_array evaluating whether each has been paid in full by searching in the transaction repository for a a successful status for each invoice.
3.	*Create the sold_item_quantity_hash.*   
By iterating through the paid_in_full_invoices array, we create a hash where the keys are item ids and the values represent the quantity of that item sold. 
4.	*Create the most_sold_item_array*  
We then find the max quantity in the sold_item_quantity_hash. We iterate through the item_quantity_hash and find each key (invoice_id) where the value equals the max quantity. By reaching through the merchant repo, through the sales engine, and into the item repository, we find the item object that corresponds with the found item_id and put it into a collector array.
5.	*Pass the most_sold_item_array to the sales analyst.*  
Once we have our results array, we pass it up through the merchant repository, through the sale engine, to the sales analyst upon request.  

**sales_analyst.best_item_for_merchant**  
We accomplish this method by first completing the following steps within each merchant object.  
1.	*Create the all_invoices_array*
We reach into the invoice repository to find all of the invoices associated with the merchant.  
2.	*Create the paid_in_full_invoice_array*  
We iterate over the all_invoices_array evaluating whether each has been paid in full by searching in the transaction repository for a a successful status for each invoice.  
3.	*Create the sold_item_revenue_hash.*   
By iterating through the paid_in_full_invoices array, we create a hash where the keys are item ids and the values represent the quantity of that item sold.  
4.	*Find the best_item*  
We then find the max revenue in the sold_item_revenue_hash. By reaching through the merchant repo, through the sales engine, and into the item repository, we find the item object that corresponds with the found item_id.  
5.	*Pass the most_sold_item_array to the sales analyst.*  
Once we have our resulting item object, we pass it up through the merchant repository, through the sale engine, to the sales analyst upon request.  

