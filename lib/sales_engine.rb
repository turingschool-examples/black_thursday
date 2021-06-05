require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_analyst'

class SalesEngine
  attr_reader :items,
              :merchants,
              :analyst

  def initialize(paths)
    @items     = ItemRepository.new(paths[:items])
    @merchants = MerchantRepository.new(paths[:merchants])
    @analyst   = SalesAnalyst.new(self)
  end

  def self.from_csv(paths)
    new(paths)
  end
end
