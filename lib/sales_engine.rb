require 'csv'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'

class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(data_files)
    @items = ItemRepository.new(data_files, self)
    @merchants = MerchantRepository.new(data_files, self)
  end

  def self.from_csv(data_files)
    se = SalesEngine.new(data_files)
  end

  def merchant_output(merchant_id)
    @merchants.find_by_id(merchant_id)
  end

  def item_output(merch_id)
    @items.find_all_by_merchant_id(merch_id)
  end
end

# se = SalesEngine.from_csv({
#   :items     => "./data/items.csv",
#   :merchants => "./data/merchants.csv",
# })
#
# merchant = se.merchants.find_by_id(12334195)
# puts merchant.items

# item = se.items.find_by_id(263395237)
# puts item.merchant
