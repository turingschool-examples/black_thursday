#sales_engine
# require './lib/item_repository'
# require './lib/merchant_repository'

class SalesEngine
  attr_reader :items, :merchants

  def initialize(items, merchants)
    @items = ItemRepository.new(items)
    @merchants = MerchantRepository.new(merchants)
  end
end
