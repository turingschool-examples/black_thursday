require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'

class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(paths)
    @items     = ItemRepository.new(paths[:items])
    @merchants = MerchantRepository.new(paths[:merchants])
  end

  def self.from_csv(paths)
    new(paths)
  end
end
