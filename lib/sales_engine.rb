require_relative 'item_repository'
require_relative 'merchant_repository'

class SalesEngine

  attr_reader   :items,
                :merchants,
                :parent

  def initialize(filepath = nil, parent = nil)
    @items      = ItemRepository.new(filepath[:items], self)
    @merchants  = MerchantRepository.new(filepath[:merchants], self)
    @parent     = parent
  end

  def self.from_csv(data)
    SalesEngine.new(data)
  end

end
