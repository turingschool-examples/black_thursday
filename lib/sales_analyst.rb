class SalesAnalyst
  attr_reader :item_repository, :merchant_repository

  def initialize(item_repo, merchant_repo)
    @item_repository = item_repo
    @merchant_repository = merchant_repo
  end
end
