class SalesAnalyst
  attr_reader :merchant_repo,
              :item_repo

  def initialize(merchant_repo, item_repo)
    @merchant_repo = merchant_repo
    @item_repo = item_repo
  end

end
