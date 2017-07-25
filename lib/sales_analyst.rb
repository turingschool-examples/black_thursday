class SalesAnalyst

  def initialize(engine)
    @engine = engine
  end

   def average_items_per_merchant
     # How many products do merchants sell?
     # Do most of our merchants offer just a few items or do they represent a warehouse?
   end

   def average_items_per_merchant_standard_deviation
     # Note on Standard Deviations
     #
     # There are two ways for calculating standard deviations – for a population and for a sample.
     #
     # For this project, use the sample standard deviation.
     #
     # As an example, given the set 3,4,5. We would calculate the deviation using the following steps:
     #
     # Take the difference between each number and the mean and square it
     # Sum these square differences together
     # Divide the sum by the number of elements minus 1
     # Take the square root of this result
     # Or, in pseudocode:
     #
     # set = [3,4,5]
     #
     # std_dev = sqrt( ( (3-4)^2+(4-4)^2+(5-4)^2 ) / 2 )
   end


  def merchants_with_high_item_count
    # Which merchants sell the most items?
    # Maybe we could set a good example for our lower sellers by displaying the merchants who have the most items for sale.
    # Which merchants are more than one standard deviation above the average number of products offered?
  end

  def average_item_price_for_merchant(merchant_id)
    # What are prices like on our platform?
    # Are these merchants selling commodity or luxury goods?
    # Let’s find the average price of a merchant’s items (by supplying the merchant ID):
  end

  def average_average_price_per_merchant
    # Then we can sum all of the averages and find the average price across all merchants
    #(this implies that each merchant’s average has equal weight in the calculation):
  end

  def golden_items
    # Given that our platform is going to charge merchants based on their sales, expensive items are extra exciting to us. Which are our “Golden Items”,
    # those two standard-deviations above the average item price? Return the item objects of these “Golden Items”.
  end

end
