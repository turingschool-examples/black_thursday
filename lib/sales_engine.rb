require './lib/item_repository'
require './lib/merchant_repository'

class SalesEngine

  def self.from_csv(source_files)
    SalesEngine.new(source_files)
  end

  attr_reader :items,
              :merchants

  def initialize(source_files)
    @items = ItemRepository.new(source_files[:items])
    @merchants = MerchantRepository.new(source_files[:merchants])
  end

end
