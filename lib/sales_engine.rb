require_relative "../lib/merchant_repository"
require_relative "../lib/item_repository"
class SalesEngine
  attr_reader :items, :merchants

  def initialize(items, merchants)
    @items = ItemRepository.new(items)
    @merchants = MerchantRepository.new(merchants)
  end

  def self.from_csv(info)
    self.new(info[:items], info[:merchants])
  end




end
