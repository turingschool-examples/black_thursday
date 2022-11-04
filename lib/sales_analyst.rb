class SalesAnalyst
  attr_reader :engine
  def initialize(engine = nil)
    @engine = engine
  end
  def average_items_per_merchant
    # require 'pry' ; binding.pry
    (item_amount.sum / item_amount.length.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    Math.sqrt(divide_diff_and_square_sum).round(2)
  end

  def item_amount
    @engine.merchants.all.map do |merchant|
      @engine.find_all_by_merchant_id(merchant.id).length
    end
  end

  def diff_and_square
    item_amount.map do |amount|
      (amount - average_items_per_merchant)**2
    end
  end

  def diff_and_square_sum
    diff_and_square.sum
  end

  def divide_diff_and_square_sum
    diff_and_square_sum / (item_amount.length - 1)
  end

  def merchants_with_high_item_count
    #check every merchant
    #iterate through every merchant and look at item amount
    #go through item amounts for every merchant
    #check that amount, see if it is greater than the method average_items_per_merchant
    #plus standar deviation

    @engine.merchants.all.find_all do |merchant|
      #require 'pry' ;binding.pry
      merchant.items.length > (average_items_per_merchant + average_items_per_merchant_standard_deviation)
    end
  end



end
