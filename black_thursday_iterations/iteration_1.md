---
layout: page
title: Black Thursday Iteration 1
---

Iteration 1 - Starting Relationships and Business Intelligence
=============

With the beginnings of a Data Access Layer in place we can begin building relationships between objects and derive some business intelligence.

Starting the Relationships Layer
-------------

Merchants and Items are linked conceptually by the `merchant_id` in `Item` corresponding to the `id` in `Merchant`. Connect them in code to allow for the following interaction:

```ruby
se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})
merchant = se.merchants.find_by_id(12334112)
merchant.items
# => [<item>, <item>, <item>]
item = se.items.find_by_id(263395237)
item.merchant
# => <merchant>
```

Starting the Analysis Layer
-----------

Our analysis will use the data and relationships to calculate information.

Who in the system will answer those questions? Assuming we have a `se` that's an instance of `SalesEngine` let's initialize a `SalesAnalyst` like this:

```ruby
sa = SalesAnalyst.new(se)
```

Then ask/answer these questions:

### How many products do merchants sell?

Do most of our merchants offer just a few items or do they represent a warehouse?

```ruby
sa.average_items_per_merchant # => 2.88
```

And what's the standard deviation?

```ruby
sa.average_items_per_merchant_standard_deviation # => 3.26
```

### Note on Standard Deviations

There are two ways for calculating standard deviations -- for a population and for a sample.

For this project, use the sample standard deviation.

As an example, given the set `3,4,5`. We would calculate the deviation using the following steps:

1.  Take the difference between each number and the mean and square it
2.  Sum these square differences together
3.  Divide the sum by the number of elements minus 1
4.  Take the square root of this result

Or, in pseudocode:

```
set = [3,4,5]

std_dev = sqrt( ( (3-4)^2+(4-4)^2+(5-4)^2 ) / 2 )
```

### Which merchants sell the most items?

Maybe we could set a good example for our lower sellers by displaying the merchants who have the most items for sale. Which merchants are more than one standard deviation above the average number of products offered?

```ruby
sa.merchants_with_high_item_count # => [merchant, merchant, merchant]
```

### What are prices like on our platform?

Are these merchants selling commodity or luxury goods? Let's find the average price of a merchant's items (by supplying the merchant ID):

```ruby
sa.average_item_price_for_merchant(12334159) # => BigDecimal
```

Then we can sum all of the averages and find the average price across all merchants (this implies that each merchant's average has equal weight in the calculation):

```ruby
sa.average_average_price_per_merchant # => BigDecimal
```

### Which are our *Golden Items*?

Given that our platform is going to charge merchants based on their sales, expensive items are extra exciting to us. Which are our "Golden Items", those two standard-deviations above the average item price? Return the item objects of these "Golden Items".

```ruby
sa.golden_items # => [<item>, <item>, <item>, <item>]
```
