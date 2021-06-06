require 'csv'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'item'
require_relative 'merchant'
require_relative 'sales_analyst'

class SalesEngine
  attr_reader :merchants, :items, :analyst

  def initialize(paths)
    @items = ItemRepository.new(paths[:items], self)
    @merchants = MerchantRepository.new(paths[:merchants], self)
    @analyst = SalesAnalyst.new(self)
  end

  def self.from_csv(paths)
    SalesEngine.new(paths)
  end
end
