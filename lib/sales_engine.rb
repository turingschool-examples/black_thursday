require './lib/merchant_repository'
require './lib/item_repository'

class SalesEngine

  attr_reader :merchants, :items

  def initialize(item_merchant_hash)
    @items = ItemRepository.new(item_merchant_hash[:items])
    @merchants = MerchantRepository.new(item_merchant_hash[:merchants])
  end

  def self.from_csv(item_merchant_hash)
    SalesEngine.new(item_merchant_hash)
  end

  # def items(merchant_id)
  #
  # end

  def merchant(merchant_id)
    result = @merchants.find_by_id(merchant_id)
    return result
  end

end

se = SalesEngine.from_csv({:items => "./data/items.csv", :merchants=>"./data/merchants.csv"})
p merchant = se.merchants
item = se.items.find_by_id(263395237)
