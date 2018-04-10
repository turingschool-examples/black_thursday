require './lib/item_repository'
require './lib/merchant_repository'

class SalesEngine

  attr_reader :items,
              :merchants

  def initialize(path)
    @items = ItemRepository.new(path[:items], self)
    @merchants = MerchantRepository.new(path[:merchants], self)
  end

  def self.from_csv(path)
    se = SalesEngine.new(path)
  end
end
