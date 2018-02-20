require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'

class SalesEngine
  attr_reader :items,
              :merchants
  def self.from_csv(files)
    SalesEngine.new(files)
  end

  def initialize(files)
    @items = ItemRepository.new(files[:items])
    @merchants = MerchantRepository.new(files[:merchants])
  end
end
