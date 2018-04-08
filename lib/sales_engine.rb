require_relative 'fileio'
# Sales Engine class for managing data
class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(item_repo, merchant_repo)
    @items = item_repo
    @merchants = merchant_repo
  end

  def self.from_csv(items_and_merchants)
    items_repo = ItemRepository.new(FileIO.load(items_and_merchants[:items]))
    merchants_repo = MerchantRepository.new(FileIO.load(items_and_merchants[:merchants]))
    new(items_repo, merchants_repo)
  end
end
