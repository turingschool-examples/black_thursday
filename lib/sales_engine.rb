require_relative 'item_repository'
require_relative 'merchant_repository'

class SalesEngine

  attr_reader   :items,
                :merchants

  def initialize(filepath = nil)
    @items      = ItemRepository.new(filepath[:items], self)
    @merchants  = MerchantRepository.new(filepath[:merchants], self)
  end

  def self.from_csv(data)
    SalesEngine.new(data)
  end

end
