require "csv"
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'

class SalesEngine
  def self.from_csv(data_files)
    se = SalesEngine.new
    se.merchants(data_files[:merchant])
    se.items(data_files[:items])
  end

  def merchants(filename)
    MerchantRepository.new(filename)
  end

  def items(filename)
    ItemRepository.new(filename)
    # self.find_all_by_merchant_id(merchant_id)
  end

end

se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})
 merchant = se.merchants.find_by_id(12334105)

 merchant.items
