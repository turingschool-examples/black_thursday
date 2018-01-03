require 'csv'
require './lib/item_repository'
require './lib/merchant_repository'

class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(items, merchants)
    @items = items
    @merchants = merchants
  end

  def self.from_csv(data)
    items = ItemRepository.new(data[:items], self)
    merchants = MerchantRepository.new(data[:merchants], self)
    SalesEngine.new(items, merchants)
  end

end


se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})



 
