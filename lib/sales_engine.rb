require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'

class SalesEngine

  attr_reader :items,
              :merchants

  def initialize(item_file, merchant_file)
    @items = ItemRepository.new(item_file, self)
    @merchants = MerchantRepository.new(merchant_file, self)
  end

  def self.from_csv(file = {})
    SalesEngine.new(file[:items], file[:merchants])
  end

end
