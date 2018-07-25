# frozen_string_literal: true

require 'bigdecimal'

class SalesAnalyst
  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    merchant_count = @engine.merchants.all.size.to_f
    item_count = @engine.items.all.size.to_f
    BigDecimal((item_count / merchant_count), 3)
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    #binding.pry
    all_merchants = @engine.merchants.all

    items_per_merchant = []
    all_merchants.each do |merchant|
      items_per_merchant << @engine.items.find_all_by_merchant_id(merchant.id).size
    end
    equation = items_per_merchant.inject(0) do |sum, number_items|
      sum + (number_items - average)**2
    end
    result = Math.sqrt(equation/ (items_per_merchant.size - 1))
    BigDecimal(result, 3)
    #binding.pry
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
