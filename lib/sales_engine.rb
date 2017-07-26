require './lib/item_repository'
require './lib/merchant_repository'

class SalesEngine

  attr_reader :items,
              :merchants

  def initialize(item_file, merchant_file)
    # @items = ItemRepository.new(item_file, self)
    @merchants = MerchantRepository.new(merchant_file, self)
  end

  def self.from_csv(file = {})
    SalesEngine.new(file[:items], file[:merchants])
  end

end
