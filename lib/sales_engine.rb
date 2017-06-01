require "csv"
require './lib/merchant_repository'
require './lib/item_repository'

class SalesEngine
  def self.from_csv(data_files)
    SalesEngine.new
  end

  def merchants
    MerchantRepository.new
  end

  def items
    ItemRepository.new
  end
end

se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})
