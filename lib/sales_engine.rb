require './lib/item_repository'
require './lib/merchant_repository'

class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(data)
    @items = ItemRepository.new(data[:items])
    @merchants = MerchantRepository.new(data[:merchants])
  end
end
