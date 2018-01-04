require './lib/item_repository'
require './lib/merchant_repository'

class SalesEngine

  attr_reader :item_repository,
              :merchant_repository

  def initialize(repository)
    @item_repository = ItemRepository.new(repository[:items], self)
    @merchant_repository = MerchantRepository.new(repository[:merchants], self)
  end

end
