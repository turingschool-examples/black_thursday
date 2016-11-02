require_relative 'item_repository'
require_relative 'merchant_repository'
require 'pry'
require 'csv'

class SalesEngine
  attr_reader   :paths,
                :items,
                :merchants

  def initialize(paths)
    @paths = paths
    @items = ItemRepository.new(paths[:items])
    @merchants = MerchantRepository.new(paths[:merchants])
  end

  def self.from_CSV(paths)
    SalesEngine.new(paths)
  end

end