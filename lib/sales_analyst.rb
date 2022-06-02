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

    list = items_count_list.sample(5)
    index_1 = 0
    index_2 = 1
    sum = 0
    while index_1 < list.length
      sum += ((list[index_1] - list[index_2])^2)
      index_1 += 1
      index_2 += 1
    end

    sqrt(sum / (list.length - 1))
  end

  def merchant_ids
    @merch_ids = @merchant_repository.all.map do |merchant|
      merchant.id
    end
  end

  def items_count_list
    items_list = @merch_ids.map do |id|
      @item_repository.find_all_by_merchant_id(id).count
    end
  end
end
