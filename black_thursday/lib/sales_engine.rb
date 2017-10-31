require 'csv'
require_relative 'merchant'
require_relative 'merchant_repository'
require_relative 'item'
require_relative 'item_repository'

class SalesEngine
  attr_reader :items,
              :merchants

  def self.from_csv(csv_files)
    SalesEngine.new(csv_files)
  end

  private
  def initialize(repositories)
    @items     = ItemRepository.new(repositories[:items], self)
    @merchants = MerchantRepository.new(repositories[:merchants], self)
  end
end
