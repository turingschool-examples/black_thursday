require "csv"
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'

class SalesEngine
  def self.from_csv(data_files)
    SalesEngine.new
  end

  def merchants
    MerchantRepository.new
  end

  def items
    #Return array of items that match the merchant
    # that we called using its merchant ID
    ItemRepository.new
  end
end

se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})
 merchant = se.merchants.find_by_id()
