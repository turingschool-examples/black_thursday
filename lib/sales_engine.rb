require './lib/merchant_repository'
require './lib/item_repository'

class SalesEngine

  attr_reader :merchants, :items

  def initialize(item_merchant_hash)
    @items = ItemRepository.new(item_merchant_hash[:items])
    @merchants = MerchantRepository.new(item_merchant_hash[:merchants])
  end


  def self.from_csv(item_merchant_hash)
    se = SalesEngine.new(item_merchant_hash)
  end

end
