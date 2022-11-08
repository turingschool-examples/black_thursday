## Black Thursday

Find the [project spec here](http://backend.turing.io/module1/projects/black_thursday/).

Blog;

Most sold item for merchant;


Best item for merchant;
The best item for merchant searchs the the merchant based of its ID and returns the item that has generated the highest revenue (quantity times unit price.) To achieve this we have created a helper method paid_invoice_items_by_merchant(merchant_id). This iterates over the invoice_item and finds all that match. It then checks to confirm they are paid for, calling on a previous method invoice_paid_in_full?
If the invoice has been paid in full, we then use max_by to enumarate over the collection. This compares a certain value each time it runs through the collection selecting the larges amount. For the best item for merchant method max by selects the invoice item which has the largest quantity times by unit price. 