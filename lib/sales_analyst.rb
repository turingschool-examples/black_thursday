class SalesAnalyst
  attr_accessor :item_repository, :merchant_repository

  def initialize(item_repository,merchant_repository)
    @item_repository = item_repository
    @merchant_repository = merchant_repository
  end

  def average_items_per_merchant
    (@item_repository.all.count.to_f / @merchant_repository.all.count.to_f).round(2)
  end

  def standard_deviation #of a given merch or for the entire group?
    counts = []
    @merchant_repository.all.each do |merchant|
      counts <<  @item_repository.find_all_by_merchant_id(merchant.id).count
    end
    total = counts.sum {|difference| (difference - average_items_per_merchant) ** 2}
    Math.sqrt(total / (counts.length - 1)).round(2)
  end

  def merchants_with_high_item_count
    merch_array = []
    @merchant_repository.all.each do |merchant|
      if (merchant.standard_deviation - standard_deviation) > 1 #functions aren't called properly yet
        merch_array << merchant
      end
    end
    merch_array #would return array of merch's that are "more than 1 standard deviation above avg # of products offered"
  end

  # def difference_between_merchant_items_and_mean
  #   #do we need a helper method to determine mean of all vendors?
  #
  # end
  #
  # def sum_of_differences_squared
  #   #not sure what sum?
  # end
end
