## Black Thursday

Find the [project spec here](http://backend.turing.io/module1/projects/black_thursday/).

Project completed by:
Aether Kerstens ** Bryan Flanagan ** Christian McCabe ** Samuel Cox

What was the most challenging aspect of this project? 
  - 

What was the most exciting aspect of this project?
  - 

Describe the best choice enumerables you used in your project. Please include file names and line numbers.
  - 

Tell us about a module or superclass which helped you re-use code across repository classes. Why did you choose to use a superclass and/or a module?
  - 

Tell us about 1) a unit test and 2) an integration test that you are particularly proud of. Please include file name(s) and line number(s).
  -

Is there anything else you would like instructors to know?
  -

blog post (500 words) - 
As part of our project, we were faced with writing tests and code to satisfy the following:
  ** Which item sold most in terms of quantity and revenue? **
No tests were included in the spec harness to guide us in the direction of solving the above query, however clues were provided in the iteration pattern that we would be passing in the argument of merchant_id to get our returns, and that 2 separate methods would need to be written and tested.

Both tests are similar in that they take in a merchant_id as an argument to find the 'highest performing' item in that merchant's catalog, but the criteria they fulfill to determine what constitutes 'highest performing' differs, and there is an opportunity for one method to return multiple tie answers. 

Looking at our first method, most_sold_item_for_merchant, we knew that we would first need to find all of the invoices within the invoices.csv file associated with any given merchant by referencing the merchant's ID. Once those invoices are isolated from the rest of the invoices within the invoices.csv file, we then needed to access the inventory sold within each invoice. Contained within the invoice_items.csv file are instances of each invoice, and those instances  include individual items and the quantity of said items sold on that transaction. By parsing through the invoice_items.csv using invoice_id's pulled from the invoices.csv file as our identifiers, we were able to then count the total number of each individual widget sold within all of the invoices associated with the merchant and add them together for an individual item total. Once we had these totals, we organized the list of items in descending order, and returned the top performing item(s) based on the total amount of each item sold by our merchant. 

Our second method, 
Questions for instructors
1. Aether - 

2. Bryan - 

3. Christian - 

4. Samuel - 


