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
    @items = ItemRepository.new(source_files[:items], self)
    @merchants = MerchantRepository.new(source_files[:merchants], self)
  end

end
