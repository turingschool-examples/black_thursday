require "./lib/item_repo"

class SalesEngine
  attr_reader :item_repository,
              :merchant_repository

  def initialize(item_filename, merchant_filename)
    @item_repository     = ItemRepository.new(self,item_repository)
    @merchant_repository = MerchantRepository.new(self, merchant_filename)
  end

  def self.from_csv(directory)
    item_filename = directory[:item]
    merchant_filename = directory[:merchant]
    SalesEngine.new(item_filename, merchant_filename)
  end
  
  # def merchant(id)
  #   merchant_repository.find_by_id(id)
  # end

  #.from_csv({
#   :items     => "./data/items.csv",
#   :merchants => "./data/merchants.csv",
# })
end
