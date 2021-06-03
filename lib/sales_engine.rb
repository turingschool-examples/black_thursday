require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'sales_analyst'
require 'csv'

class SalesEngine
  attr_reader :items, :merchants
  def initialize(path)
    @items = ItemRepository.new(path[:items])
    @merchants = MerchantRepository.new(path[:merchants])
  end

  def self.from_csv(path)
    new(path)
  end

  def analyst
    SalesAnalyst.new
  end

end
