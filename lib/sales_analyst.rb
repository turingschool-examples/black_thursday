class SalesAnalyst
  attr_reader :item_repository, :merchant_repository

  def initialize(item_repo, merchant_repo)
    @item_repository = item_repo
    @merchant_repository = merchant_repo
  end

  def average_items_per_merchant
    (@item_repository.all.length.to_f / @merchant_repository.all.length).round(2)
  end

  def average_items_per_merchant_standard_deviation
    merchant_ids
    items_count_list
    list = items_count_list # list = items_count_list.sample(5)
    mean = list.sum.to_f / list.size
    sum = list.sum {|num| (num - mean)**2}
    sd = (Math.sqrt(sum / (list.size - 1))).round(2)
  end

  def merchant_ids
    @merch_ids = @merchant_repository.all.map {|merchant| merchant.id}
  end

  def items_count_list
    items_list = @merch_ids.map {|id| @item_repository.find_all_by_merchant_id(id).count}
  end

  def merchants_with_high_item_count
    sd = average_items_per_merchant_standard_deviation
    high_sellers = merchant_ids.find_all do |id|
      @item_repository.find_all_by_merchant_id(id).count > sd * 2
    end
    high_seller_merchants = high_sellers.map {|seller| @merchant_repository.find_by_id(seller)}
  end
end
