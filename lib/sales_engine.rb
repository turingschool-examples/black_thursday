require_relative 'item_repository'
require_relative 'merchant_repository'
# Ties together DAL
class SalesEngine
  attr_reader :items, :merchants
  def initialize(attributes)
    @items = ItemRepository.new
    @items.from_csv(attributes[:items])
    @merchants = MerchantRepository.new
    @merchants.from_csv(attributes[:merchants])
  end

  def self.from_csv(attributes)
    SalesEngine.new(attributes)
  end
end
