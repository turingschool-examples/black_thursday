require_relative 'item_repository'
require_relative 'merchant_repository'
require 'pry'

# Data Access Layer that interacts with repositories
class SalesEngine
  attr_accessor :items, :merchants

  def initialize(repositories)
    @items = ItemRepository.new(repositories[:items])
    @merchants = MerchantRepository.new(repositories[:merchants])
  end

  def self.from_csv(repositories)
    new(repositories)
  end
end
