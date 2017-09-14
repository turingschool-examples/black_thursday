require './lib/item_repository'
require './lib/merchant'
require './lib/merchant_repository'

class SalesEngine

  def self.from_csv(source_files)
    SalesEngine.new(source_files)
  end

  attr_reader :items_repository,
              :merchants_repository

  def initialize(source_files)
    @items_repository = ItemRepository.new(source_files[:items], self)
    @merchants_repository = MerchantRepository.new(source_files[:merchants], self)
  end

end
