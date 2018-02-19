require_relative 'item_repository'
require_relative 'merchant_repository'
require 'pry'

# Data Access Layer that interacts with repositories
class SalesEngine
  attr_reader :items, :merchants

  def initialize
    @items = nil
    @merchants = nil
  end

  def self.from_csv(repositories)
    engine = self.new
    engine.items = ItemRepository.new(repositories[:items])
    engine.merchants = MerchantRepository.new(repositories[:merchants])
    engine
  end
end
