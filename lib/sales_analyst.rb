class SalesAnalyst
  attr_reader :merchant_repo, :item_repo
  def initialize(merchant_repo, item_repo)
    @merchant_repo = merchant_repo
    @item_repo = item_repo
    @merchant_items_hash = {}
  end

  def group_items_by_merchant_id
    @merchant_items_hash = @item_repo.all.group_by { |item| item.merchant_id }
  end


  def average_items_per_merchant
    # avg = @item_repo.all.count.to_f / @merchant_repo.all.count.to_f
    group_items_by_merchant_id
    items_per_merchant = @merchant_items_hash.map do |merchant, items|
      items.count
    end
    avg = items_per_merchant.sum.to_f / items_per_merchant.count
    avg.round(2)
  end

  def average_items_per_merchant_standard_deviation
  end
end
