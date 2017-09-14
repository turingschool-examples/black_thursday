require './lib/item_repository'
require './lib/merchant'
require './lib/merchant_repository'

class SalesEngine

  def self.from_csv(source_files)
    SalesEngine.new(source_files)
  end

  attr_reader :item_repository,
              :merchant_repository

  def initialize(source_files)
    @item_repository = ItemRepository.new(source_files[:items])
    @merchant_repository = MerchantRepository.new(source_files[:merchants])
  end

  def items
    item_repository.find_all_by_merchant_id(self.id)
  end

end
