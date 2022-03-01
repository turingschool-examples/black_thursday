class SalesAnalyst
  attr_reader :merchant_repo, :item_repo
  def initialize(merchant_repo, item_repo)
    @merchant_repo = merchant_repo
    @item_repo = item_repo
  end

  def average_items_per_merchant
    avg = @item_repo.all.count.to_f / @merchant_repo.all.count.to_f
    avg.round(2)
  end
end
