require './lib/item_repository'
require './lib/merchant_repository'
# require './lib/merchant_repo'

class SalesEngine

  attr_reader :item_repository, :merchant_repository

  def initialize
    @item_repository = ItemRepository.new(self)
    @merchant_repository = MerchantRepository.new(self)
  end

  def self.from_csv(filename)
    

  end

  def merchant(id)
    merchant_repository.find_by_id(id)
  end

end
