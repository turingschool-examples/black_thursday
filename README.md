## Black Thursday

Find the [project spec here](http://backend.turing.io/module1/projects/black_thursday/).
## Black Thursday



The most challenging aspect of this project was working with the CSV files. It was a new challenge to use data stored in those files by importing it into our code.
We also had some challenges with the sales analysis class. Reaching through objects and many of the files/classes that were named similarly made this particularly difficult. Finally, with how large this project was, it was also challenging keeping all the moving parts organized.

The most exciting aspect of this project was learning how to access large amounts of data to get the answers that you are looking for. This will allow for future projects to be much more involved as our code can now process much larger data sets, making the potential functionality of the code we write more compelling. Refactoring was a fun challenge to see how we could better right our code and think of our code in nuanced ways. The use of modules was also new for this project, and it was interesting to see how they could be leveraged. Having the opportunity to get lots of practice using gitflow on GitHub, as well in the terminal, was an added bonus for this project.

The the method average_item_price_for_merchant on line 48 of our sales_analyst file shows the best use of the range of enumerables that we used for this project. We used .map to insure that we were getting a new array with out having to state it explicitly in the method. We then used .sum to find the items price that way we could then devide that number by the items per merchant which we then found using the .count enumerable.

We elected to group all the repository methods into the same module as this made the most sense due to the level of overlap. This also allowed us to dry our could and organize out project for coder empathy. 

With average_item_per_merchant on line 10 and  merchant_count on line 18, with this data we had to incorperate it into the average_items_per_merchant_standard_deviation on line 34. This intergation and unit tests are what we are particularly proud of due to this being a large part of our sales analysis. Each method helped with antoher method and if one was even slightly off we ended up getting bad data. Were this was frusterating this also helped us learn how to better de-bug our code.

This was a great challenge that helped us grow as new coders, using the resources available to us and self-teaching when there were gaps in our knowledge.

Blog post
The following two methods are not covered by the spec harness. As a group, write a blog post of approximately 500 words as to how these methods work. Include this as a section in your project README.

7 & 8. Which item sold most in terms of quantity and revenue:
sales_analyst.most_sold_item_for_merchant(merchant_id) #=> [item] (in terms of quantity sold) or, if there is a tie, [item, item, item]

When we made this method we first sorted the items by merchant id. We then iterated through the merchant id to get a single item. With this item we created a hash with the item being the key. We wanted to make sure to then compair items as the values. For the values we went into invoice items to find all the items with the items id that we were looking for. We then got the sum of that data by adding the quanity of sold items together. This was then arranged into descending order inside of the hash. This allowed us to grab the first value of that array. We then used this to check if there were any other items that were equal. If there was that ment there was a tie and all items would be printed out into an array. If no tie was to be had then the single top item would print.


sales_analyst.best_item_for_merchant(merchant_id) #=> item (in terms of revenue generated)

We wanted to store this information into a hash. To do this we first iterated through to fine the merchant id. We then checked to see if the invoice was fully paid, this was a extra helper method that was made to get this information. We that we went through all of the invoice items to find the specific invoice id that we were looking for. We made the item id the key of our hash and the value was the amount of revinue that item made. This was then arranged into descending order inside of the hash. This allowed us to grab the first value of that array. We then used this to check if there were any other items that were equal. If there was that ment there was a tie and all items would be printed out into an array. If no tie was to be had then the single top item would print.

Q&A
As individuals:

Please include a minimum of 1 question from each group member (max: 3 questions per group member). Include these questions as a section in your project README. Your evaluating instructor will answer these in your feedback video.

*  with having to find multiple standard devation methods could this have also been made into a module and would this have made the test run faster?
*  with so many files/class being similar is there a way to help with writer empathy when writing methods that are reaching from the top to the bottom of the chain?
*  Would you have recommended using mocks and stubs to run faster tests? Are those acceptable to include in a "final code?"
