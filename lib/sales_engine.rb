require 'CSV'
require './lib/item'
require './lib/merchant'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/sales_analyst'

class SalesEngine
  attr_reader :items, :merchants

  def initialize(files)
    @items = ItemRepository.new(files[:items])
    @merchants = MerchantRepository.new(files[:merchants])
  end

  def self.from_csv(files)
    instance = SalesEngine.new(files)
  end

  def analyst
    SalesAnalyst.new
  end
end
