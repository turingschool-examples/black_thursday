class SalesAnalyst

  attr_accessor :item_repository, :merchant_repository

  def initialize(item_repository,merchant_repository)
    @item_repository = item_repository
    @merchant_repository = merchant_repository
  end

# average items per merchant
# merchant.each item.count

  def average_items_per_merchant
    (@item_repository.all.count.to_f / @merchant_repository.all.count.to_f).round(2)
  end

  def standard_deviation
    counts = []
    @merchant_repository.all.each do |merchant|
      counts <<  @item_repository.find_all_by_merchant_id(merchant.id).count
    end
    total = counts.sum {|difference| (difference - average_items_per_merchant) ** 2}
    Math.sqrt(total / (counts.length - 1)).round(2)
  end
  #
  #     average_items_per_merchant
  #   (@item_repository.find_all_by_merchant_id(merchant_id).count.to_f - average_items_per_merchant.to_f).abs
  # end

  # def sum_of_differences_squared
  #   return_num = 0
  #   @item_repository.all.each do |item|
  #     return_num += (difference_between_merchant_items_and_mean(item.id) ** 2)
  #   end
  #   return_num.round(2)
  # end
  #
  # def average_items_per_merchant_standard_deviation
  #   Math.sqrt((sum_of_differences_squared / (@merchant_repository.all.count - 1))).round(2)
  # end

end
