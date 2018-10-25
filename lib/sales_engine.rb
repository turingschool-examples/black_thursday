require_relative "../lib/merchant_repository"
require_relative "../lib/item_repository"
require_relative './sales_analyst'

class SalesEngine
  attr_reader :items, :merchants, :analyst

  def initialize(items, merchants)
    @items = ItemRepository.new(items)
    @merchants = MerchantRepository.new(merchants)
    @analyst = SalesAnalyst.new
  end

  def self.from_csv(info)
    self.new(info[:items], info[:merchants])
  end


end
