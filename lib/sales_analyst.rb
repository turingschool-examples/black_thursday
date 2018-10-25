class SalesAnalyst

  def initialize(merchant_repo, item_repo)
    @merchants = merchant_repo.merchants
    @items = item_repo.items
  end

  def average_items_per_merchant
    (@items.count.to_f / @merchants.count).round(2)
  end

end
