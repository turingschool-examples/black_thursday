require_relative 'item_repository'
require_relative 'merchant_repository'

class SalesEngine
  attr_reader   :paths,
                :items,
                :merchants

  def initialize(paths)
    @items = ItemRepository.new(paths[:items], self) if paths[:items]
    @merchants = MerchantRepository.new(paths[:merchants], self) if paths[:merchants]
  end

  def self.from_csv(paths)
    SalesEngine.new(paths)
  end

end