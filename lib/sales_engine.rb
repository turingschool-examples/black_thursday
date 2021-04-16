require 'CSV'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/sales_analyst'

class SalesEngine
  attr_reader :merchants, :items, :analyst
  def initialize(csv_data)
    @merchants = MerchantRepository.new(csv_data[:merchants])
    @items = ItemRepository.new(csv_data[:items])
    @analyst = SalesAnalyst.new(self)
  end

  def self.from_csv(csv_data) #needs to be parsed here; should not need to call e.g. salesenging.merchants
     SalesEngine.new(csv_data)
  end
end
