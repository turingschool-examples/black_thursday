class SalesAnalyst
  attr_accessor :item_repository, :merchant_repository

  def initialize(item_repository,merchant_repository)
    @item_repository = item_repository
    @merchant_repository = merchant_repository
  end

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
end
