
class SalesAnalyst
  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    #count how many merchants there are
    merchant_count = @engine.merchants.all.size
    #for each merchant count thier items
    #add together all items sold total for all merchants
    # then divid the sum of items sold by the number of merchants
    #return the mean as a big decimal
  end

  def average_items_per_merchant_standard_deviation
    #run the above method(average items per merchant)
    # get all the merchants
    #count how may items each merchant sells and put it in an array
    #iterate - for each item in the array minus mean and square the result
    # return an array of the squared differences
    #sum the whole array together
    #divide the sum by the number of elements it had minus 1
    # take the square root of the result
    # return a big decimal

  end

  def merchants_with_high_item_count
    # run the above method to get the SD
    # and one to the above number
    # get all the merchants
    #iterate over each merchant to compare the number of items they sell
    #with the SD plus 1
    #if they sell more items than the SD + 1
    # shovell them into an array of high item count merchants
  end

  def average_item_price_for_merchant(merchant_id)
    #find the merchant using the id
    #count how many items the merchant sells
    #get a list of all merchant item prices
    #sum all the item prices together
    #divide the sum by the total count
    #return big decimal
  end

  def average_item_price_per_merchant
    # iterate - perform the above methos on all merchants
    # sum total / divid by total number of merchants
    #return big decimal
  end

  def golden_items
    #run above method to get the average item price for all merchants
    #see above
  end
end
