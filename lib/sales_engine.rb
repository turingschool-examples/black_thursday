require 'CSV'
require './lib/item_repository'
require './lib/merchant_repository'
require 'pry'

class SalesEngine

  def self.from_csv(hash)
    SalesEngine.new(hash)
  end

  attr_reader :items,
              :merchants

  def initialize(hash)
    @items = ItemRepository.new(hash[:items], self)
    @merchants = MerchantRepository.new(hash[:merchants], self)
  end

end