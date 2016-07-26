require './lib/item_repository'
require './lib/merchant_repository'

class SalesEngine
  attr_reader :items, :merchants

  def initialize(items_path, merchants_path)
    @items = ItemRepository.new(items_path)
    @merchants = MerchantRepository.new(merchants_path)
  end

  def self.from_csv(hash)
    items_path = hash[:items]
    merchants_path = hash[:merchants]
    SalesEngine.new(items_path, merchants_path)
  end
end
