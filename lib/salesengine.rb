require './lib/item_repository.rb'
require './lib/item.rb'
require './lib/merchant_repository.rb'
require './lib/merchant.rb'

class SalesEngine
  attr_reader :items, :merchants

  def initialize(files)
    @items = ItemRepository.new(files[:items])
    @merchants = MerchantRepository.new(files[:merchants])
  end

  def self.from_csv(files)
    SalesEngine.new(files)
  end

end
