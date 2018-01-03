require 'csv'
require './lib/item_repository'
require './lib/merchant_repository'

class SalesEngine
  def self.from_csv(data)
    @items = ItemRepository.new(data[:items], self)
    @merchants = MerchantRepository.new(data[:merchants], self)
    self
  end

  def self.items
    @items
  end

  def self.merchants
    @merchants
  end

end


se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})

merchant = se.merchants.find_by_id(12334112)
p merchant.items
