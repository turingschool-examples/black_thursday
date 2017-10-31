require "./lib/item_repo"

class SalesEngine
  attr_reader :item_repository,
              :merchant_repository

  def initialize
    @item_repository     = ItemRepository.new(self)
    @merchant_repository = MerchantRepository.new(self)
  end

  def merchant(id)
    merchant_repository.find_by_id(id)
  end

  #.from_csv({
#   :items     => "./data/items.csv",
#   :merchants => "./data/merchants.csv",
# })
end
